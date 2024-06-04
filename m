Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47216C25B7E
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 04:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C18C610E18A;
	Tue,  4 Jun 2024 04:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Km+QcPmZ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9149810E18A
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 04:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glN1zvOuPXsBDHF8rdmj0VkTTHVe644/a6Q0XYpIuJSOZeAw1q2bRHAq2jMW50zofnlyqbLgfgr4n09QUYXGWlZOZYIhQgmCZYAoRHmZDnP1zd7lIJbqkukhyMG+RIX9QTLzvlToqaMoyG3Mdtb9PghBVZL6BXArPNacJJA60EPJAOCmSTM7T17FdILac9MMoGesG/B47CUJG0pODh/flEFY0dhcyIvSSnulotST07+bfOIv3UlIt+mIP4ougBpeeIULP9Wb+dZq3dDrLJr7YvwzKvC2qyZdrOgkovWAiSxdWfz2GXpaqrtOR8XXJux+ynAGqMeIe+rFl9Ey27eNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udafAzvtYhFUl2u/xreyvwqbD+xTUUlq2ljyZM3rHAc=;
 b=UMCJjGhBvoET61SwrkNeiLL5HTRZINMsmdRW1i7ICg10pD5ZyxVATX+C9JTckSvekt7E//hOX34+5YHlFopTGaP9sMObhiP1f5K9vSDWVvzPaoc6dwObHeYWzzaZnvHI66g29wQrroInFNVunTg6c2+gJ2lRRoeyPQSHWOw1tbP950ICnRe8FwhzaQ0efr8y/k5XZARSaAwZ8AH60nTOkX91VEKOmK1dDFHV76OeIVg9/7CZC7ODCn7BcZcR0YoUk99H03vGrEd+lpJ3dv5miDany0XpL6NwqCKzFs3UkKG63H4qPUH3Vs7IjkSEk4vK5ty6TwBcNRhOULCItqZFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udafAzvtYhFUl2u/xreyvwqbD+xTUUlq2ljyZM3rHAc=;
 b=Km+QcPmZ3YnC+Q+1Fgu7shtgElymSDo5oU+Koazl/8y0ukEevRV87cDqmo9MVEdoQX4tEDcLDLMl+u+VlWg+3BXqE+4dqwNsm8jM9woZql+PsCPfxsRku0sYeZmkLnxHdvztaz43IA0epOZrsm5UlXjQMBnucvMOUDzfoTEXL+k=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.26; Tue, 4 Jun
 2024 04:15:40 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 04:15:40 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 05/12] drm/amd/pm: remove dead code in
 navi10_emit_clk_levels and navi10_print_clk_levels
Thread-Topic: [PATCH 05/12] drm/amd/pm: remove dead code in
 navi10_emit_clk_levels and navi10_print_clk_levels
Thread-Index: AQHatZK6ONMBj5Sd2USPLcNmrjF9U7G1v1bggAEQ9YCAABMKAIAAFoCAgAAGX8A=
Date: Tue, 4 Jun 2024 04:15:40 +0000
Message-ID: <PH7PR12MB5997618219724022D331CB2782F82@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240603084730.2569970-1-jesse.zhang@amd.com>
 <DM4PR12MB601207AD23D14B7BB64B3CB082FF2@DM4PR12MB6012.namprd12.prod.outlook.com>
 <DM4PR12MB515268FF505C25FCC69D0724E3F82@DM4PR12MB5152.namprd12.prod.outlook.com>
 <PH7PR12MB5997EDE36BBA361D761AF9D482F82@PH7PR12MB5997.namprd12.prod.outlook.com>
 <DM4PR12MB5152C1D9F255F98E8B7531ABE3F82@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152C1D9F255F98E8B7531ABE3F82@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=689ec0ae-dbd8-4a02-a8dd-a477a98b33ef;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-03T09:05:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|IA0PR12MB8326:EE_
x-ms-office365-filtering-correlation-id: 2f610866-9e34-42e2-2c29-08dc844cfeba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?coQnJcs3aMnj6nfs+l20fiLreONRbf6XPLzf2OmcXBPgoe+3Ct/MK6Tcfwnr?=
 =?us-ascii?Q?O0e2nq1lbmTSfoOcZbkq8mE/oDfJsMxR2eSeO3iwdF0Rt4iQkz7K/jPOXDHc?=
 =?us-ascii?Q?DUQNkXWCUlKAp2wJSVWRGKIWTPc1fw6U3M2NchhX6zQ2ErGRcdWMpQ//dVQH?=
 =?us-ascii?Q?7SACbc3J8hasV18J5oMVN9zGR5J0Dlkq+6HGTQjUo7RKKj7fymW5O7xZve2+?=
 =?us-ascii?Q?APzHauulnlzkq3mRZ2w1ScsY9F/QwFTIjon1b2X2IFDAkUAhRdytfoqb2WTm?=
 =?us-ascii?Q?53+DZqX9xk7RbqeWQ3l6r4v/M93ZFZ1ogLAot5SErK0wU3xzLSY2/b76+5xB?=
 =?us-ascii?Q?QEvIFIDN9ZP7DqZUKvk3zCINjVcRaqI1swiqcnp3EUtdNBAfwZGuB0H4JGPF?=
 =?us-ascii?Q?kVxatp69ipTPzI0BP6KuxSp8ERDVdivR1F+WgBxKnNwYAbJLcEZGN2YkUi7n?=
 =?us-ascii?Q?aYpZA6YhlpeJQy0fUI2WPaVvNdXS9HoPGzRw+FsU3Di9+kpTHhl6T1fB+Z4I?=
 =?us-ascii?Q?f/6eCCQLZseI5eFQyiPlP+cUvBeUZ27gFXcnMI1cCSWb/wWxptZDJ5qbujtB?=
 =?us-ascii?Q?nyy0CJNWEVvAg3n8t/a5HcLMSRuD3gwmOMZr0bxblcXe6A7pJKXk3zK0P2ag?=
 =?us-ascii?Q?Gd2UCO1CFSvxcrVMtBrhUWGvQOaQO00MWR8ewASYr0nC7bUvOfSq5gdqHdHU?=
 =?us-ascii?Q?yqZSRkA+hDZYodId0WEhtVakoITuBnYe+TVMaobcwSEAOUX+4Z48yjj7Uk1M?=
 =?us-ascii?Q?IqWlrYlAeTK1EXrCatQRmnWsGudZHC7U4XXuCge0ImbMX3vAc5iYvGh4eZo3?=
 =?us-ascii?Q?P2PxvuLgQtoNtVLpfZeVg9Tw6m97R2kvqNMbnO+Qy+JeTu302HlZETbKUtOk?=
 =?us-ascii?Q?SucnvXE//MCN75ek6IUAlxAR2JEVhYvF4hvazRt3x0VKDZsgf6ya9+RgKdMM?=
 =?us-ascii?Q?d8RsXJEfxuf8DKOsj9h3T0OpK9UNmaBTva64XKVZzYfQaIka4yReRE3pmkvj?=
 =?us-ascii?Q?KtVjOnAI+PI/+or78SO8aA5324axWaTSZfojKHpZ88z5O93uWbnw0veZfkd9?=
 =?us-ascii?Q?CTPlkb5JIlPGkaMVYvrp4io/ZZ4UIprw44zu7SHQKtV8pSyp8irXMJS29Ybr?=
 =?us-ascii?Q?RluQUONoZpx5wxXxoS+N5nt5ZYbocOoVcOQwY8qsG6xiVuwOAIQwVZ0KipGx?=
 =?us-ascii?Q?POXlo1yur6AZsQwPs6R6lOcK7HANMAa4wMjhZSfzMCQrXzHyY0t8GxrjMCer?=
 =?us-ascii?Q?m6cOqRQIsUFmjE+Qj8SJmGZy3/PKUgGE1gLaS22TVk3YcQROid44i7xqZZ2A?=
 =?us-ascii?Q?B9IfXXFAc+51NRLIVtSowoA5g56KDBtJGLzy49TBPqiGCg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LKidIrTqskHbO4wHgKxHUmsgvQ19tGnmKWX+Fn/VPuWuEK8UyluWg7U+hd11?=
 =?us-ascii?Q?LkS4hcV+tEDvaTLq7LkBHXCiB57ECI0xWK0+H1tiXKWNHBfoQq3zkQpxZilu?=
 =?us-ascii?Q?R+Ao8X4yBCJolhyilpb98xCNhXF50ehdjJ5O43WS/DBUarJmDe3ckKpbHZNN?=
 =?us-ascii?Q?pz8FtDpsJiuSLzEJ17v9JBUNl55amdxD2dXPJG+iGqsi3aPj8esUmPOvZRJK?=
 =?us-ascii?Q?O4oFfE3xVQcvk5FJTvdzCRzAmHnKUl9kCM2RvKkajiDai8/4EgAzsqLSfLZT?=
 =?us-ascii?Q?7cQky1RpP/tRzdkuyL/19koYrI9wkO+CmKbXpjwE7HB9/WNQ/T3d3KUo0APi?=
 =?us-ascii?Q?fGNCBSNc4YkSDe+eJ3uQ2RacbFgAuZRMnexDCKUTBJGVxz3tlyraG5VYYMqf?=
 =?us-ascii?Q?SaT1y6YR0FkqNSHgrpG68CtoO3OvRKX1JKHqQLz7qF+CGWjAjs52rfT+IAA4?=
 =?us-ascii?Q?Osd/pD7JH5U7XQQ3VPdRXSjglF5tEbxbudRgbcGBbEfmCV3L8hGRuCGj5Z4z?=
 =?us-ascii?Q?mSLb6k2Z4IFg7oPqg5vQpYUT9uvLA623qNfPm9ILSafTyrMiOeWvKzqc+NMv?=
 =?us-ascii?Q?Qd7b7dm0285fQpcVYTNN/ozkI6fhXSxXttWFq295tE1e9K/FHc85+k9lJmSU?=
 =?us-ascii?Q?KhMVoXfAzewUHWyFaEyjLU6Z5dZt/RJF/X4fOEZ4NyoaUBhXnRjkNnbonqPt?=
 =?us-ascii?Q?ioVySo66QYkotd3q0NLkgVXUQfQfhlToRYzL1LUb7npqM1j66jdFbopZ2tid?=
 =?us-ascii?Q?0uBDz+7hWh3j95ZiUThjucjz8lIoS3AhXbo3HzCHrvbUrlASVO2W6qIt/L3q?=
 =?us-ascii?Q?Asp4W+ZSSJbm/oYrXRzdKjxbaia94ND41Qk2UWez9grf+jsKrDNVZwWBYDmu?=
 =?us-ascii?Q?5KZjyqfryyOthMLWXR/OS/O6Ay/ST3bNrJZvKglZ+T+qqoXZd0KLy5avjvj+?=
 =?us-ascii?Q?a5jYBdgBvWeWu40xyfvcdFgP3X11Bvy148CsdksSZx3GKGGZL9cIPY2N0irm?=
 =?us-ascii?Q?hcQzZ1BPt8UQ3Jr0/RXClLIK5tJpmELmHdimH0q4LhSBZ/+Oj5HnxgXPMQwA?=
 =?us-ascii?Q?IinHeP8fj2s3WLTxgWLDwYlgcHF0OumjNCRtPhhszk9FeDiZRkzJ2B1Khrop?=
 =?us-ascii?Q?KdQWt7bRhClcw22KA0DpHYdud4pEf6HU093fQpBexAXV2f5Nq+Q0yk4iOEMQ?=
 =?us-ascii?Q?Dcf7Ea5YDtQddbqPI1mybiFg3TIIhLyeutBofnRAFZEgY7LdeoxFyGeE8CZ6?=
 =?us-ascii?Q?T5SJyxbfnwwn6ulxdygn55xv/0Fpe25FO4m7l0jcvAoGgyYDQnkpII9JvxlL?=
 =?us-ascii?Q?auvYnVZXrNe85iJL/1/PjynU2GmUMMPv6wDp9tXAUxjuEs+hQ3+rgo7Q/1IB?=
 =?us-ascii?Q?+9BXefWR6tPWXM5QDWlFeNjGipgg7uBUjyqUN9IbwyBkL9ae0QLcr+96P2SF?=
 =?us-ascii?Q?k5OYZl9t3lDt2Z9Xa6aB8twF4JJdOJiQNSJshRLrcdxaCLlGyaxnrMs1s2Nq?=
 =?us-ascii?Q?VhqeEq6NWsSzNGQTqBLC9AnXjFRhlQXFaRPnv9hggO2snnedJajK2tYn46sz?=
 =?us-ascii?Q?VhZFKAdeUiOJ2ua9H/M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f610866-9e34-42e2-2c29-08dc844cfeba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 04:15:40.5214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ET1R0Nl7L96+rrGhRXZzR8DLZWice30l28Ti/FVlc16EswfkhwPsJcFokU/C4nQh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Thank you for your clarification.

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Sent: Tuesday, June 4, 2024 11:52 AM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Tim=
 <Tim.Huang@amd.com>
Subject: RE: [PATCH 05/12] drm/amd/pm: remove dead code in navi10_emit_clk_=
levels and navi10_print_clk_levels

[AMD Official Use Only - AMD Internal Distribution Only]

Hi  Kevin

I guess you didn't apply the patch correctly.
This patch doesn't remove default branch  for clk_type.
In the case of SMU_OD_VDDC_CURVE in function navi10_emit_clk_levels , The v=
ariable i ranges from 0 -3, so the default branch in case SMU_OD_VDDC_CURVE=
  cannot be executed.

static int navi10_emit_clk_levels(struct smu_context *smu,
                                  enum smu_clk_type clk_type,
                                  char *buf,
                                  int *offset) {

        switch (clk_type) {
         ...
        case SMU_OD_VDDC_CURVE:
                if (!smu->od_enabled || !od_table || !od_settings)
                        return -EOPNOTSUPP;
                if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_O=
DCAP_GFXCLK_CURVE))
                        break;
                *offset +=3D sysfs_emit_at(buf, *offset, "OD_VDDC_CURVE:\n"=
);
                for (i =3D 0; i < 3; i++) {
                        switch (i) {
                        case 0:
                                curve_settings =3D &od_table->GfxclkFreq1;
                                break;
                        case 1:
                                curve_settings =3D &od_table->GfxclkFreq2;
                                break;
                        case 2:
                                curve_settings =3D &od_table->GfxclkFreq3;
                                break;
                        default:  //don't need the default case.
                                break;
                        }
                    ....
        }

Thanks
Jesse

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, June 4, 2024 10:39 AM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Tim=
 <Tim.Huang@amd.com>
Subject: RE: [PATCH 05/12] drm/amd/pm: remove dead code in navi10_emit_clk_=
levels and navi10_print_clk_levels

[AMD Official Use Only - AMD Internal Distribution Only]

  CC [M]  drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/navi10_ppt.o
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c: In function 'navi10_emit_clk_levels':
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_VCLK1' not ha=
ndled in switch [-Wswitch]
 1275 |         switch (clk_type) {
      |         ^~~~~~
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_DCLK1' not ha=
ndled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_ECLK' not han=
dled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_DISPCLK' not =
handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_PIXCLK' not h=
andled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_PHYCLK' not h=
andled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_LCLK' not han=
dled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_CCLK' not =
handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_VDDGFX_OFF=
SET' not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_FAN_CURVE'=
 not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_ACOUSTIC_L=
IMIT' not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_ACOUSTIC_T=
ARGET' not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_FAN_TARGET=
_TEMPERATURE' not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_FAN_MINIMU=
M_PWM' not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_CLK_COUNT' no=
t handled in switch [-Wswitch]
  LD [M]  drivers/gpu/drm/amd/amdgpu/amdgpu.o

After applied your patch , the kernel will show above compile warnings with=
 'W=3D1' flag.
# grep -nR -A 1 "default:" drivers | grep -i 'break' -B 1 And the above com=
mand will show all similar cases in kernel driver folder.

So, your patch is not necessary as my understanding.

Best Regards,
Kevin

-----Original Message-----
From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Sent: Tuesday, June 4, 2024 9:23 AM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Tim=
 <Tim.Huang@amd.com>
Subject: RE: [PATCH 05/12] drm/amd/pm: remove dead code in navi10_emit_clk_=
levels and navi10_print_clk_levels

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Kevin,


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, June 3, 2024 5:09 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Tim=
 <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse=
(Jie) <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 05/12] drm/amd/pm: remove dead code in navi10_emit_clk_=
levels and navi10_print_clk_levels

[AMD Official Use Only - AMD Internal Distribution Only]

Could you share the problems you encountered?
Some compilers may prompt you to forget to handle default cases.
[Zhang, Jesse(Jie)] These warning scan by Coverity. These are useless redun=
dant codes.

Thanks
Jesse

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse Zh=
ang
Sent: Monday, June 3, 2024 4:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Tim=
 <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse=
(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 05/12] drm/amd/pm: remove dead code in navi10_emit_clk_leve=
ls and navi10_print_clk_levels

Since the range of the varibable i is 0 - 3.
So execution cannot reach this statement: default.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index cf556f1b5ed1..076620fa3ef5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1389,8 +1389,6 @@ static int navi10_emit_clk_levels(struct smu_context =
*smu,
                        case 2:
                                curve_settings =3D &od_table->GfxclkFreq3;
                                break;
-                       default:
-                               break;
                        }
                        *offset +=3D sysfs_emit_at(buf, *offset, "%d: %uMHz=
 %umV\n",
                                                  i, curve_settings[0], @@ =
-1594,8 +1592,6 @@ static int navi10_print_clk_levels(struct smu_context *s=
mu,
                        case 2:
                                curve_settings =3D &od_table->GfxclkFreq3;
                                break;
-                       default:
-                               break;
                        }
                        size +=3D sysfs_emit_at(buf, size, "%d: %uMHz %umV\=
n",
                                              i, curve_settings[0],
--
2.25.1





