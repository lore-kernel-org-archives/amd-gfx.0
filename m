Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09287C61DA4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 01:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4281E10E1BE;
	Tue,  7 Feb 2023 01:57:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A367D10E1BE
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 01:57:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb/J9BM1Ob8x089jjrIjq+5IQ8GLMF/5b2gX9YROEjj8o4OptDosYD6W3G/ovvCVEVaT0KmYvmSt0SZV12KADFt/lEvSW0eZoQ0/EH5ujTpc9Wb04iOInTG+DJZwcbCF9KlQnMkq1Ui7d+ZOiz7uuER2IYKcwOfmSuAhMD/tnC+Qzmlqj/xXd8ABYhvLSd1xlyaIivEpYrZtHkHMqtaxEvdQE51JptI5gm+yyw1TeaK2Su7Mp7XqPtGhQClGxFFSUK7/dhsKtZwrZZKlzD4v0+g91fZ1aTmOYRO4ZHAtjvP2fhOPiVKYeEXnaNkDyYxp2MjYgjJTMhBEI6my+ZrCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVqyIQzM/HfkVOHLgtbTbXyvo+cPm1FO+uLhU4y96Lg=;
 b=hkPpnXGe0+jjIcoyBcJDgM5ks7Lg/H3gry9y/1E7kZo/YFwK/StxZxLrZCJgda/gTepDu1l43mSoMKB68ZxVa6rgyiz2FUZhGyDMBvX5bSVIIJif0TiPLeQ/IRvtd4Wve/wuXmxStwH4U7XHKMNN25V7aPnO+zs1CJemB0zAZabqSnPdFNYuvCzk9bjUY3QFMB0lrC6gfiM1ttD7Xxxm36s9qMMFyoL+Nmsr85vBxBs4kPl3KiAMkSflxnnDhsDfd1MicOGDZymZGD8CD5TTHUvsk8F5G4SJbRXp7kGTosUpYKumxXvD/CCBzWtcQhMHayf0gXvQnt3i4aWdAmuA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVqyIQzM/HfkVOHLgtbTbXyvo+cPm1FO+uLhU4y96Lg=;
 b=jVdz/g+57USOQ654Sb2c0axXYNhjTV7WTblKmHvDJ+RdgMH8CvTiLTSNsyYnx2ICPXRHa4uZjus1EPWtsXq5Q1GiPW33qNXqWDr/x07jvbT5T+ddhvGuUfdJGPGiOaaY5PjCDkipxKSjBZ39tAYP3ec17osQ0VqXJ+ibvxJUb0o=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 01:57:43 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8617:d09d:24bc:a683]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8617:d09d:24bc:a683%3]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 01:57:43 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: add SMU 13.0.7 missing GetPptLimit message
 mapping
Thread-Topic: [PATCH] drm/amd/pm: add SMU 13.0.7 missing GetPptLimit message
 mapping
Thread-Index: AQHZN7Om7RrchWmXNEOr+VFVCmud167Cv7CA
Date: Tue, 7 Feb 2023 01:57:43 +0000
Message-ID: <CH2PR12MB41527B63DAD241E1F70C6044FEDB9@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20230203093928.3445781-1-evan.quan@amd.com>
In-Reply-To: <20230203093928.3445781-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-07T01:57:40Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e5ad55e4-885d-42cb-a55e-8da8e6b5a83c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-07T01:57:40Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: a938d4fb-53ae-4443-8aaf-272cd3399a39
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|BN9PR12MB5050:EE_
x-ms-office365-filtering-correlation-id: faf446a9-6dd6-4468-be4b-08db08aeb383
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ov9WbqSOu4CiDT4+n1SGLwOTAJ/EHCEG4o3M2X8DPybtnF43F4e0YSTK/ljduFF/zHnHDwNKJRFyh2037wI+ReZHo3nwF0C33uIsE8H3MxjxArsvnaAd7drCWmVweGHhHXYF6Xw3V1p6RMfBnP69oAkXtNEPCcXny++Axyx8jIWc9dKnTMcmHZkVkPQG+mG7CeQFtPMYmxqLtLehkcx+Qj6Hh3D7c5BnKZwennEl/t1kL80A5BQ3/+yqumlViQ0x+DcLzgAaCx2tc2Dum+WHBWnbcren+K+L8fQMqhpMyUVTFdejy0uZnkfGIwmkbeIIDqkFgl5t7x4SJIBbqKo1x0hHl75pRfCY23mfdEkxek/zm5ftnQ6nJ8LXLe+GN9hbZVofe65im7hPRKMifWSdjbuNEt8zfhdmcb78NIRCqxBGLdFPuSBVcSHn+bD3Xo6RlDAjKgGAcZS7xVWj+epgD3Sjb2QWxwjGKDpx/852jy1CmOGJmBdI5cvt4gDlx7k5xrJtZTvL4dM2eUCEx7yK9NgxsqDHAXoHZbir9VIBEjPMGhfiD48JEtG8+5WTe7zcyuzrm5Z9hMOxEn9RfbvOY7osmjamQlGYmSMH53iQUbdFsNP4vU3Ld7+T/6znbQG104fpJ1JEZb8urqs5ESqGwMiXt6G+hkqFUYKfs38Lq3L73QNHGuS93IHnbGNvnhRKIQP8lJnZpSFRlXZ6fu5ExA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199018)(64756008)(66446008)(55016003)(478600001)(53546011)(6506007)(8676002)(26005)(186003)(9686003)(4326008)(66556008)(316002)(76116006)(66476007)(110136005)(66946007)(7696005)(54906003)(71200400001)(38070700005)(38100700002)(122000001)(86362001)(33656002)(83380400001)(5660300002)(41300700001)(52536014)(8936002)(15650500001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MSmVH6kN566skfCSLkU0osRXmUilpL0Zyhhr9AgKi9oylTjX8IPb4yxp5MxV?=
 =?us-ascii?Q?h9K7ad+atRfVv+kElBkvustoM8OatzPRsFKTq20dpzaCZrWfxDN2q7Y7uXk3?=
 =?us-ascii?Q?P0Xwj7uYFgwS6lrGcLfxGQs9FCtkn6C9Haq/P6SgAVRMPmII9ESd9Lf99THW?=
 =?us-ascii?Q?1Z79g7k/+TmFhOVlvqHJ8juPI89LKaS1nPkgDZx1iwo3dN5HmsjL7mnuGMrE?=
 =?us-ascii?Q?k3I/ncAkIoBqL9JfDK/jLf8nxQ7JZJElvHPrt8gOmJA+8pAQ/osZM2DvP9DX?=
 =?us-ascii?Q?8vPYCXE8mdqXLoNfmiP0HuQHTKesQjsy3P5IGVEv4Dpv+uH1kxabRfKJrBGZ?=
 =?us-ascii?Q?e36ZhBbStOpx9fX8t7+IcKjSHF7/asCu7+NzfByDt5fpO6ejYGr+UKFBF4KL?=
 =?us-ascii?Q?nfuLD3ow0pOmF8gmCMS6VoM2F9vQ2G2N2zRIzHAyiedGzX+lAbvE8df0+tqn?=
 =?us-ascii?Q?ey3WlfUt/1KJhWOx3cpnk0kjRLp1kNY5QB8ctGiVJNP0J6k1rX0LRFn26VcC?=
 =?us-ascii?Q?bkdWCnWAiHec/gUaQM18U3+VNOAUgxiYMouQsVreeUgoOzjvRC0izFAWwvfw?=
 =?us-ascii?Q?6nerSUXyglgJDVb9o+eWIHg/9C0Pbhu/DCYnWu3Piw9kPDM2y/gxr2fFUFWG?=
 =?us-ascii?Q?2ccYgUkC7UvJAaLDcxzEEEbz9lyjvdODrZtYCCuIKm3OF4V1dSLSjZ2FYjaU?=
 =?us-ascii?Q?nq6Du/s1SCNSGv+/l1D8QuAvAV9YpTGLJ4ayLZmBYTubg9nSkPrTjzVxQtn0?=
 =?us-ascii?Q?WnntkXdLtb21t+55yyyJOSIHWfmHKTusTdU/vVLAF4CHXtu/Gw2HS5Qti1Yo?=
 =?us-ascii?Q?OKVVEEwqVYr4wkdAjZzjVxUqLEGHFTeOqbvTkKWtZ2cIU5DNCreX91k7VHe9?=
 =?us-ascii?Q?SeH+TJAdiFvSnBMfcPAHZ6I3FPGiXRS/5u3k+efYHgevgfzBDv74W0S+gAeJ?=
 =?us-ascii?Q?03UUPHBHfEPfDRBKqJvWbJjvvrVjjlVG8KdwdeAb5Gvi7GEavAMRZDc4fkne?=
 =?us-ascii?Q?gCq/KIafROSe7zvZmsMxLk2j+kwFQqfhtLW3iU9TgdlIAodXh5UQB6fx8Yiw?=
 =?us-ascii?Q?PYSKiRdJPAwaR9yBvjaS4TrzBJeZrVDJgGQd5FjIF3/etH4H1CVNQX2wjP6G?=
 =?us-ascii?Q?5VrAJ027KssW7f7XnpsJ+cLjTH/ejpaA8wPRIzBDrGTjV1AvX6u8pneez/hv?=
 =?us-ascii?Q?XoSGLUfTwOc88ZCgGWntmk/RXCgAAhZ3mMPTQHbTIqrcID+AZ47ZAixTLUIP?=
 =?us-ascii?Q?ovXG2FjvRle0zTBt2fNKQc9QAA29/7Ye7E7Xh2hdw8Gk9TDHZCIMPosb4Opz?=
 =?us-ascii?Q?I97UEZ9vNCmN9qWHz1MFAMuNx+5pFl6ix9K02seiPp+JE7y63pZTe42O8UX+?=
 =?us-ascii?Q?J8tfHgb9KG0FVhu+1kkMeW9v8OwhZyX2DJNv7hZgN5LbvDgeIK16SHVgdN2Q?=
 =?us-ascii?Q?6Z/NoHbQvgKvfJkYtf1sIVcCFb561xJi8BQONKYR9gYCEVDfaB6RkIwS2LUI?=
 =?us-ascii?Q?KsUrXlTfllOMla1ngOF5dMokgXMzIywjS1lrzYGyyDV/hPd+CW2LM60m0BXv?=
 =?us-ascii?Q?YmlAvzaKf5VfOooOWAo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf446a9-6dd6-4468-be4b-08db08aeb383
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 01:57:43.1675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K46L0VQbmNOrUMoitfLSG+gmYFYMFVc0O4TN6GdWhDG5mnAT5mZRWU9DNO7TNVgF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Friday, February 3, 2023 5:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amd/pm: add SMU 13.0.7 missing GetPptLimit message map=
ping

Add missing GetPptLimit message mapping.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ic4edfa3153988721a6ee66dd69a1d4ca8a5ea45c
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 02ee248899c0..6a882c4f7cee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -124,6 +124,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_=
map[SMU_MSG_MAX_COUNT] =3D
 	MSG_MAP(DFCstateControl,		PPSMC_MSG_SetExternalClientDfCstateAllow, 0),
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       0),
 	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
+	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
 };
=20
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] =3D {
--=20
2.34.1
