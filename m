Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A21BC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 09:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25BA10E236;
	Wed,  3 Jan 2024 09:50:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F216010E236
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 09:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzGMjGu5EaJlZC1I5aBfMrq2U5lnyRhL13fAybm9x3z2W+2PzYKeCT69s3iqAxkIppENyFb9Sc3LXVK3Ep83papr2Wj7LcgB6KS+0F037VJroaWmhPtRGtfAOv3eGixxTIBUmKb+AALWnBpGB8cVb2FH9ThxIOy90IY1llpCv2Yf8e9sLXmMXUCcw3Aa2MTKTjiBrAD3QlYfdkEQZJSlArOB/OiVhIa7FlovJhKFV6M6wN7rM2bZrJsrYDygHYvF6uBgiL86NrrdGOyLFVcjJwxlRxDtamcx+AOKLj7c9ox7+fVpCqBPFJ9IfhZh22v3p+xCk0zZvXmB+FKm8jddhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIdqi6UXDSM2Z+SdFLoLxzUvQ+6ReOU5drVnFk6jGU8=;
 b=jcDWNx9P7/n1vQnOujeHFcRBdf+FU4WBJl9JyIXuMUHkiqn2H/DaZZ8ujJKsUJrsuG5izx4N0ZIu5THjTYKNiucdkICpx8Fd0I2MMomjbo20Rb12MTLC5FFkF+l6oCzppK/qLt/04nVNp85MA2XnskRDYI7Dwpum6ccRwx1BEYKCI2HmJT/5PAxs2kplWlXxMJFD5pTJbLCNevBbO8KQqbNpwUItTJ8TRk9cR34bENpfADUpE/i6PL3RiTmLVBbbBv53EeovIh4iQjDgi4/3YM8gx9l3Gil6u4EmDIdLe2m8bsEvp1zeplJgRoqqquWwClm46E6y44GXZhD2smVMyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIdqi6UXDSM2Z+SdFLoLxzUvQ+6ReOU5drVnFk6jGU8=;
 b=BcTkYTU071ViJT4viIVAdCNho85Rf/leTCspyhnBxBff9fixZAgTbtt6zxATA8wxqRJ+ozQAit4bQ9fLQAVuPWO8R0CFTwotvA4MsmGpaREJ6iJxwc+NTamhXudCeMhrd3mhglZlBwoEGB+6bZwxcmf/Nn90TZPiAut3i6kb0FU=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 09:50:48 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 09:50:48 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error log
 support
Thread-Topic: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error log
 support
Thread-Index: AQHaPhtLqfXwb1Q4NUCMjL6tVWYZ+bDH1EuAgAAD/GA=
Date: Wed, 3 Jan 2024 09:50:47 +0000
Message-ID: <PH7PR12MB5997A84D82FDAFF8A3B42A6F8260A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
 <20240103080220.2815115-3-kevinyang.wang@amd.com>
 <BL1PR12MB5254BCA35F540F3169D8CFECFC60A@BL1PR12MB5254.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5254BCA35F540F3169D8CFECFC60A@BL1PR12MB5254.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=61f822be-dba5-47ee-bf0a-7524a42547c6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T08:37:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ2PR12MB7944:EE_
x-ms-office365-filtering-correlation-id: 45be36f3-abd9-4b6b-9d4c-08dc0c417681
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: StqUe8r5dVeEx+yOAdjL6K95LEGGnO8Nw8eFwA2gYtPvL74YxVO6IQGctqE47Hw5vZHS7KJtblQcRkHSbivC0O7wAsb7lxMpW2jTOvG3SepbDTKSCosZLrnSJuNOuGcbEo4C6ECpu2A8HyVwDliEfKVzYMNaVySuVtb/0vz+udgEJ1Xmnb6QpjWIRr1ft+KLZ2ME9RdmsdWuOxE1pUqsdBAlJAJlHrd100Pd6FOfV7AnC7sMXhm6W2Q4BRYYM65V67bGB+/UZ6st9+sHA1ARUrR6vDrQBvfO9JQivXOxDRj7QHcEnyFCXJze3rNPrsTS8h2ccVX91x+M1dZSDEWzz9LkVvqe6OY3qc7dZDV/+1q2r54/MlPn4nJlcpNkhWu3pMh90YOd6cThTbp2WdcNRd6dIXp3grsVaztbVjLkzciz0zYUSEnMwxO4AcHIw5dwMv/ELUPjy1ZtMM4x5xGketqK4da6jPpSM5awKuQgVbBZjzRLOf6DrevJBQi0Pyb9CZrvSXrr8wH7ilLWTADCYL8Dhr2ORdM7319yPZTR3qWYZHDPHdZBdWGsWoT5+Baz4xr1PKyXKf4qOtBohO/3o8bfnSe0vnihA2XktURUDMJLFnlyqQWJAz+YFv9c55lA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(33656002)(41300700001)(26005)(38100700002)(122000001)(83380400001)(8676002)(52536014)(110136005)(54906003)(5660300002)(8936002)(316002)(4326008)(2906002)(966005)(7696005)(71200400001)(30864003)(478600001)(66556008)(76116006)(38070700009)(6506007)(64756008)(66476007)(66946007)(9686003)(86362001)(66446008)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TzVRY21zWVdHSHZuS3k5dWdVVzZXR1l6RXNkVkVqSTgvdnFhNmsrbU0y?=
 =?iso-2022-jp?B?djVTdGJ0eURGa05PNEozZmsvYmxWRnRsbkYwMUdFc2tUSXdMYWZmYUk3?=
 =?iso-2022-jp?B?ZDM2MTU1ZmZ0YjBjdWNJdlF5QmdxamhXRllDV1MzUHJKbWFtMkFRVitD?=
 =?iso-2022-jp?B?azlOdUdYWUxPWWFMTXJ1L2NBTzhGOVNFNzFEbG9SUEJxdXNQVzRLL2FF?=
 =?iso-2022-jp?B?NzZUdFdyVWRNUWtDL1Nub2VONWFVcmFOVW11UUJOZ1JydFJlRVVwckNT?=
 =?iso-2022-jp?B?RlBoSjN2UzdJblc0TDYyMTZJeDN3bmg1SEc0N29xT2pCZjZkcW9BN0JL?=
 =?iso-2022-jp?B?SEY0c3Baa2M0MnZMVTlQbDNqSkdjcSthWWo1Vnc1YVBpQlA3bExucEFV?=
 =?iso-2022-jp?B?MEFhSFhoVEZac2t4UUpCTnBaa2VvWWhNUVpqQ3JnOEJYWnh1UmpKbVY5?=
 =?iso-2022-jp?B?QkV4UDZYT3JCMDBsbjJ4OGxTZFdibjFVUXRUZW53N2xrUmNtbitDRmJm?=
 =?iso-2022-jp?B?QzNRVWl6UnpPM1hqM09KMHBvc3Azb25wdjlGeU14enY5L1FGOCtWVEtk?=
 =?iso-2022-jp?B?eHlKcnhpbmNmdHljZXhWVUhtMG04T3YrcUxuSFFQZXp1RUI5dk1IcFc3?=
 =?iso-2022-jp?B?dFV2ZDlzYTdMRmE2QktKczdPOGRPTEsvaXVxR2Q2b2xqdUNHb3ppSzJr?=
 =?iso-2022-jp?B?eFdqWHByU2tHa2k2TzN3VmJQd2dhVXcyeWN1RzhMN2w4MTAxczlsVTlH?=
 =?iso-2022-jp?B?ejlkVzU1eWQrNVpObjhoMkNOMkdVdW1RL0lLM1lRRjdxVklwaGt4Wjhz?=
 =?iso-2022-jp?B?QkpXZVFxMlp6QjFOaldSWXJBMlphcStOcGtoTGIwVSsweHcwMURlRzFM?=
 =?iso-2022-jp?B?b0ZEWDJzUCtRaE1pMTZBdlVleWFZcE94RjJPdktnbXBlNUlWUVBtdEFK?=
 =?iso-2022-jp?B?TjBQQ2MrQklMOWtqRkZMejlLdFFzQlZyQlpnVnBrNDBsQmM4L2hDVzd3?=
 =?iso-2022-jp?B?cXYxby81SkhsQ1BKbVl0Smh6dHJWUzM1NlExbzMvVDBDSVZQaURSRW05?=
 =?iso-2022-jp?B?Nm1oMHY5NmpwQU94SldEUjJkRkJ6MDJpV05Qb0RIVytoSDhGVEFUNmxQ?=
 =?iso-2022-jp?B?ZytuWXJKQmpnVWthWDVlaG02eSswYVhzT1dCZHNLK1JhN1VtZEhqWW5q?=
 =?iso-2022-jp?B?RHZ3bFhJcE1OTktNRll3WFl2MTkxR01IZlNhMmYrVThDQS9CWlFsa3pZ?=
 =?iso-2022-jp?B?UytBdTdiTEI0SWJMT1dFbkVBSzNsSFBnVTNwT2JGSWxlMDRyejZobHZW?=
 =?iso-2022-jp?B?TnRocnI4RlgwM3pPV3ZHMEJvUi9haWVMb3RXM0tNUHBNQVJtdE0wQlk4?=
 =?iso-2022-jp?B?Tk44U1pXMVR6LzBYakxnT2k3aDNuaXNKTE5KeEpKcTc1dHVGTjdMSlFR?=
 =?iso-2022-jp?B?WG5aQ3FGcW9pVUZVcmN0VWNYOFlpb1RqRW04OEtTTDJHTkJVcGZhL1l0?=
 =?iso-2022-jp?B?WUpjQ3BndUdSNEdHUHVQb21ibGNoZnVjRkhMaXBsZmozQm91WjVxVHVl?=
 =?iso-2022-jp?B?eEs2SXZmVTFIU2RCRVYwUzNjOU9SWThrcEdWdldJTUJWaUZrYS9wTEUv?=
 =?iso-2022-jp?B?RHh3MnhIOXBidWs4cnZ6RGNaNWwram9tVGt2bFRlREdDQURhOFkwcDd0?=
 =?iso-2022-jp?B?elloNVljclhORENyZ2Q3WEJ2ZFEvYWpyb05wQ08xMG42MmV3aGxZb3Bu?=
 =?iso-2022-jp?B?cm1IWGdHSVEwdncrQkpFaFFjaHlvUHQxanpyVDJQUmxpL0ZQclhXc1ZE?=
 =?iso-2022-jp?B?UG0wMUwyaU1wV1F3Syt5ZkVsSCtJei9QdHNEem4xM1RvNFZRT295Z05R?=
 =?iso-2022-jp?B?SkxsK2s0eUNiMWxTZDc3SDRCQnB1ZnNCazNJcFlydmo4M05iUXQ0N0tX?=
 =?iso-2022-jp?B?SlB5THF5SklkcGNNMTBHUzFrKzdPT0ZWVi9jNEZhR1lnS2twWitUZkZs?=
 =?iso-2022-jp?B?LzlaOWgzNk84ZHd0dnhVNUJUcUNPaVAzRUYyR0RhUkZnRmI2Z2sxK040?=
 =?iso-2022-jp?B?bkIyQzJXMVljcGIwZkE3bDROUlN6SEhVWHZsOVVMRUNrVmZ0WWJDdUk5?=
 =?iso-2022-jp?B?MTRtK3ovU3hVWDJSYUJpaHJzeVNBODR4TXFxaWRacG9yYkw0ei84cXZY?=
 =?iso-2022-jp?B?R0Izbmc4cGQ1TkVSemdIaWxkdHhUTEZmRTNnTjFyRlF3YVZIVHdsK3lK?=
 =?iso-2022-jp?B?TWJmZDh4Mk5GaHUxQ29qeDU1U1I3cExHUT0=?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB5997A84D82FDAFF8A3B42A6F8260APH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45be36f3-abd9-4b6b-9d4c-08dc0c417681
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 09:50:47.9969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMJztxqQLPKd+YgXt3KkjVy6Vad2ftnQL8xJFSIyBeZ8l5kOE2lgCblw5PUPRegr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB5997A84D82FDAFF8A3B42A6F8260APH7PR12MB5997namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


_____________________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, January 3, 2024 5:36 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error log su=
pport


[AMD Official Use Only - General]



+       dev_info(adev->dev, "[Hardware error] Accelerator Check Architectur=
e events logged\n");
+       /* plus 1 for output format, e.g: ACA[08/08]: xxxx */
+       for (i =3D 0; i < ARRAY_SIZE(aca_regs); i++)
+               dev_info(adev->dev, "[Hardware error] ACA[%02d/%02d].%s=3D0=
x%016llx\n",
+                        idx + 1, total, aca_regs[i].name, bank->regs[aca_r=
egs[i].reg_idx]);

We should keep the ACA log format simple since there are tools like crash d=
umper that grab these logs.

How about formatting log as below
dev_info(adev->dev, "[Hardware error] Accelerator Check Architecture (ACA) =
events logged\n");
dev_info(adev=1B$B"*=1B(Bdev, "[Hardware error] ACA.%s=3D0x%016llx\n");

In general, if the idx doesn't convey useful information, then just replace=
 it with ACA.Reg.

[Kevin]:

Agree, will update it in next version.

Best Regards,
Kevin

Thoughts?

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.c=
om>>
Sent: Wednesday, January 3, 2024 16:02
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Z=
hou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Chai, Thomas <YiPe=
ng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>; Wang, Yang(Kevin) <KevinYang.=
Wang@amd.com<mailto:KevinYang.Wang@amd.com>>
Subject: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error log suppor=
t

add ACA kernel hardware error log support.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com<mailto:kevinyang.wang@amd.=
com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index 6a6f167b5380..cadeda64eded 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -100,6 +100,33 @@ static int aca_smu_get_valid_aca_count(struct amdgpu_d=
evice *adev, enum aca_erro
        return smu_funcs->get_valid_aca_count(adev, type, count);  }

+static struct aca_regs_dump {
+       const char *name;
+       int reg_idx;
+} aca_regs[] =3D {
+       {"CONTROL",             ACA_REG_IDX_CTL},
+       {"STATUS",              ACA_REG_IDX_STATUS},
+       {"ADDR",                ACA_REG_IDX_ADDR},
+       {"MISC",                ACA_REG_IDX_MISC0},
+       {"CONFIG",              ACA_REG_IDX_CONFG},
+       {"IPID",                ACA_REG_IDX_IPID},
+       {"SYND",                ACA_REG_IDX_SYND},
+       {"DESTAT",              ACA_REG_IDX_DESTAT},
+       {"DEADDR",              ACA_REG_IDX_DEADDR},
+       {"CONTROL_MASK",        ACA_REG_IDX_CTL_MASK},
+};
+
+static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int
+total, struct aca_bank *bank) {
+       int i;
+
+       dev_info(adev->dev, "[Hardware error] Accelerator Check Architectur=
e events logged\n");
+       /* plus 1 for output format, e.g: ACA[08/08]: xxxx */
+       for (i =3D 0; i < ARRAY_SIZE(aca_regs); i++)
+               dev_info(adev->dev, "[Hardware error] ACA[%02d/%02d].%s=3D0=
x%016llx\n",
+                        idx + 1, total, aca_regs[i].name, bank->regs[aca_r=
egs[i].reg_idx]);
+}
+
 static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum ac=
a_error_type type,
                                       int start, int count,
                                       struct aca_banks *banks)
@@ -137,6 +164,8 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_de=
vice *adev, enum aca_erro
                if (ret)
                        return ret;

+               aca_smu_bank_dump(adev, i, count, &bank);
+
                ret =3D aca_banks_add_bank(banks, &bank);
                if (ret)
                        return ret;
--
2.34.1


--_000_PH7PR12MB5997A84D82FDAFF8A3B42A6F8260APH7PR12MB5997namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - General]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">____=
_________________________________________<br>

<b>From:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt; <br>

<b>Sent:</b> Wednesday, January 3, 2024 5:36 PM<br>

<b>To:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@lists.=
freedesktop.org<br>

<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Chai, Thomas &lt;YiPeng.Ch=
ai@amd.com&gt;<br>

<b>Subject:</b> RE: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error=
 log support</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div style=3D"padding-right:5pt;padding-left:5pt;"><font face=3D"Arial" col=
or=3D"blue">[AMD Official Use Only - General]<br>

</font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;[Hardware er=
ror] Accelerator Check Architecture events logged\n&quot;);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* plus 1 for output format, e.g: ACA[08/=
08]: xxxx */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(aca_regs)=
; i++)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; dev_info(adev-&gt;dev, &quot;[Hardware error] ACA[%02d/%02d].%s=3D0x=
%016llx\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idx + 1, total=
, aca_regs[i].name, bank-&gt;regs[aca_regs[i].reg_idx]);</span></font></div=
>
<div><font face=3D"Times New Roman" size=3D"2" color=3D"#2F5496"><span styl=
e=3D"font-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">We should keep the ACA log format simple since there are tool=
s like crash dumper that grab these logs.</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">How about formatting log as below</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">dev_info(adev-&gt;dev, &quot;[Hardware error] Accelerator Che=
ck Architecture (ACA) events logged\n&quot;);</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">dev_info(adev=1B$B"*=1B(Bdev, &quot;[Hardware error] ACA.%s=
=3D0x%016llx\n&quot;);</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">In general, if the idx doesn't convey useful information, the=
n just replace it with ACA.Reg.</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[Kev=
in]:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Agre=
e, will update it in next version.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Best=
 Regards,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Kevi=
n</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2" color=3D"#2F5496"><span styl=
e=3D"font-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">Thoughts?</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">Regards,</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">Hawking</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">From=
: Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com"><font col=
or=3D"#0563C1"><u>KevinYang.Wang@amd.com</u></font></a>&gt; </span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sent=
: Wednesday, January 3, 2024 16:02</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">To: =
<a href=3D"mailto:amd-gfx@lists.freedesktop.org"><font color=3D"#0563C1"><u=
>amd-gfx@lists.freedesktop.org</u></font></a></span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Cc: =
Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com"><font color=3D"=
#0563C1"><u>Hawking.Zhang@amd.com</u></font></a>&gt;; Zhou1, Tao &lt;<a hre=
f=3D"mailto:Tao.Zhou1@amd.com"><font color=3D"#0563C1"><u>Tao.Zhou1@amd.com=
</u></font></a>&gt;;
Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"><font color=3D"#056=
3C1"><u>YiPeng.Chai@amd.com</u></font></a>&gt;; Wang, Yang(Kevin) &lt;<a hr=
ef=3D"mailto:KevinYang.Wang@amd.com"><font color=3D"#0563C1"><u>KevinYang.W=
ang@amd.com</u></font></a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Subj=
ect: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error log support</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">add =
ACA kernel hardware error log support.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Yang Wang &lt;<a href=3D"mailto:kevinyang.wang@amd.com"><font co=
lor=3D"#0563C1"><u>kevinyang.wang@amd.com</u></font></a>&gt;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 29 +++++++++++++++++++++++++</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 1 f=
ile changed, 29 insertions(+)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 6a6f167b5380..cadeda64eded 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
100,6 +100,33 @@ static int aca_smu_get_valid_aca_count(struct amdgpu_devic=
e *adev, enum aca_erro</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_funcs-&gt;get_valid=
_aca_count(adev, type, count);&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic struct aca_regs_dump {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *name;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int reg_idx;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+} a=
ca_regs[] =3D {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;CONTROL&quot;,&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_CTL},</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;STATUS&quot;,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_STATU=
S},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;ADDR&quot;,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG=
_IDX_ADDR},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;MISC&quot;,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG=
_IDX_MISC0},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;CONFIG&quot;,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_CONFG=
},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;IPID&quot;,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG=
_IDX_IPID},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;SYND&quot;,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG=
_IDX_SYND},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;DESTAT&quot;,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_DESTA=
T},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;DEADDR&quot;,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_DEADD=
R},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;CONTROL_MASK&quot;,&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_CTL_MASK},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int </span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+tot=
al, struct aca_bank *bank) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;[Hardware er=
ror] Accelerator Check Architecture events logged\n&quot;);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* plus 1 for output format, e.g: ACA[08/=
08]: xxxx */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(aca_regs)=
; i++)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; dev_info(adev-&gt;dev, &quot;[Hardware error] ACA[%02d/%02d].%s=3D0x=
%016llx\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idx + 1, total=
, aca_regs[i].name, bank-&gt;regs[aca_regs[i].reg_idx]); </span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_er=
ror_type type,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; int start, int count,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; struct aca_banks *banks)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
137,6 +164,8 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device=
 *adev, enum aca_erro</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return re=
t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; aca_smu_bank_dump(adev, i, count, &amp;bank);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ret =3D aca_banks_add_bank(banks, &amp;bank);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return re=
t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
</span></font>
</body>
</html>

--_000_PH7PR12MB5997A84D82FDAFF8A3B42A6F8260APH7PR12MB5997namp_--
