Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469E5C25B4F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 02:18:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA61110E0F4;
	Mon, 13 May 2024 02:18:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xkf8+A14";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163BF10E0F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 02:18:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jF/TckcmN44KqKS2tcn78OzzWHiOUAxvtNxyy8M4cNb0j26bT422YbTa2rF1Qdb1uXkzFgbCDEVmrbZecO8So4sodF1OBDziS1QYB5M8U0Da4jSdOw1iqdALLvlFmCevO/HTFCGJkz3fUmku3zNHOY5W3EtZ9PIEQprGt598gf860+Lovt2h1kfAwTpNfRTtKNWilZLS0WRWTu1HtFi3w5x8z3zofkupC5zTjfd53W/Hlfdjgm7JxRVbIr6Awj/aI2ZNHwj0u2+lhlzu2WnPGntJ6zu5FTyJrt3JtirE8yxgUqZYosdHL53Hqu818TkjM1gV4McvsTKeD0jJI5T8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrnOOIVyeUwm/TsaYfzou+1Dk2RlmSk7pztb4WFcRCI=;
 b=EJL+PGgllBh72Sjqiysk1pLEfQrkSoQu0/DQdBc/YxidC4K986ZcH1FbxEPNg9kIYlgcvxIgCVhSzieuWnJnOiVoTH3aqIT5VHKRFxE5nFH5d2LDkK7jBrLmD3m6ivLxPdP7q90fuIHhiNCH+/WIc5hrzci3mQkr8wfcFsCKtjc1t0xEhD293Mj/VxG2yZ9fwrMdqvHU7s1AnY3YvOWbdBgVIaT6b1w2sAyO9ubDuO4LU9BDRZJ//fRtKAXLA3TSUOd1df9mbHAn3ZazQC20nnGzULIPStlO6Uk8Gxm9uKRzmiMFNERl7k2m3m81RTuXhN/RKxV/9Fys+jibrjXYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrnOOIVyeUwm/TsaYfzou+1Dk2RlmSk7pztb4WFcRCI=;
 b=xkf8+A14KVHWBJKZ7CPNd7WmYx0k4HeL2fQA7+8b8OIUsPtAOBVTrMwz/608jaloF0gc8f8OvH3OL3W5eMioqvkDDdXhsQHEad3yS3aevFO/spL/mv2nFnxw/u7BDznZigz48YowUIMbhTuSC+h8raj4+vXGmbKlH+o89Th12h0=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:18:12 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 02:18:11 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 02/22] drm/amdgpu: the warning dereferencing obj for
 nbio_v7_4
Thread-Topic: [PATCH 02/22] drm/amdgpu: the warning dereferencing obj for
 nbio_v7_4
Thread-Index: AQHaooTpk6ppaKx78kqRDqg8NF+tYLGUcoLA
Date: Mon, 13 May 2024 02:18:11 +0000
Message-ID: <DM4PR12MB515226FC7F4075DAEBF4197AE3E22@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-2-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-2-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=00c36985-9675-48a3-952d-01f98ca7c697;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-13T02:17:58Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BL3PR12MB6523:EE_
x-ms-office365-filtering-correlation-id: 8bdc83ba-17f9-4bdf-cc5f-08dc72f2f040
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?MDiqde9GP6OcB+0Y/xgev8SGHBYnUSaMN6Y4YzGrjKYnh3k/Nur61Pv2VtrM?=
 =?us-ascii?Q?GLSWb8jd7mrnghstQjcYMK6xjD9a6AWugspY/MJQouL0gTRL0JfziXNx8C+T?=
 =?us-ascii?Q?XaD/n1cZY4RHGLO4eIzBWuD4mjpHR92Hl2wr0dpqUMzilg5CDmzxx5SRTXpR?=
 =?us-ascii?Q?CPpnjUYeEXhsNJmz1pHpdqiJySCgte2GIlEO94RgRCx3Mh4G5Dyk8/JMQeCP?=
 =?us-ascii?Q?RU1Ql7lUfTTD1iovRQAYSaMnbcZhqtyWHDoU5XekSOxV8RIGN2VXWa0bpldB?=
 =?us-ascii?Q?PNaYlE71s3H4IaoesP1Of7l7HCXP+fkrAqPW4kL22OViVlYJD1I4WYY6LvFI?=
 =?us-ascii?Q?6SrW0zskiwCKsfUiRHSfuDN2IbM6m4HaHKkR0Fc/Qj++fS7fGBix6l/90dHk?=
 =?us-ascii?Q?2a4Uw44ckmQkWXwrY2o5VyqRrkqSyMs/wXSpiNdAhigNznFWnAKHEfH7RMjC?=
 =?us-ascii?Q?B0nE1otQTyqlYuvzVQTJJJpUh/G3+Kg3ZgcE29CFuuw+MKT1P8UAE02Sk0MB?=
 =?us-ascii?Q?Vzu3LXsKJ2DYrbsIHER5yLZtgPyi8lIgP4k1thxkQCrumnl1FrIIbCkujSew?=
 =?us-ascii?Q?Q9UrWswhNTFEV6AFoAUWUStisxDzchuxdcCi5UfMGryF76zBYB+uKUj+oHJu?=
 =?us-ascii?Q?fhdnw5XWsf8X3/IDe6DqrDB5ShxwwPMmo5/P9kRXWKwVCL8Efu0o7qM+n1HH?=
 =?us-ascii?Q?kP3q8kEp15A29ICZqfQz+D1R76/G5AhqBrnqnOFBl61OLcXVUbObScJMzMsB?=
 =?us-ascii?Q?nhCV+wu3qm1f5CbBnksgN0etznSCrMtRILsyO4AtJg9nqytKndaBKytet7mP?=
 =?us-ascii?Q?Vh0t+fwrRSVoH/1o8xKwdLwO0CGA9Jx5AiVARHR3FU1WuC95nPMtO9sQX143?=
 =?us-ascii?Q?Ovrj2Azp15tfmgqmlsIf65yQ0Mw/eCa5M2Jb4T/rcVty4VXzZDs+hwSjPlvg?=
 =?us-ascii?Q?gV8BLrIelP+QS3EZsOadrUdjB/kCh1HMU2HfbbEbjro3vxIpDqtr5HcBiFrf?=
 =?us-ascii?Q?ucqrkA01rixKEnpXX5miK6bataggZ0AD0wnDsURkNg+JBB+qtp9/RtRxmLj9?=
 =?us-ascii?Q?4HdRwdHq0v4ApEiLaOrsTJQygBK4IDkswK5y5SexYAmdyVAQy9xdHgtShr3W?=
 =?us-ascii?Q?JcZUf+yIqDbkbrF9qbiTpjYz37IDCw/0/MoLIwzjL75IYCyvP+8V/YZ+VcbE?=
 =?us-ascii?Q?thw+fXQmlhuzzNcuHNLVTSRHE1S4cUFm+bkQtROly6Lc1vFYJQpt8X+yoXYo?=
 =?us-ascii?Q?+q7jRafBWSZ4NIUUocGzhpsQJnhk/Qb1GPDcUS+dqMpMkAPtR9zYDs7lV+oH?=
 =?us-ascii?Q?wBgejtoHx1WbmURHPvwNhUdwXql58JqxTOHqA45E0E7zVA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uzB/HVz3hxfvE1dSz2h+TejLDT3blZ5DLSt1MxGGzebHziNtceevDyCdikQp?=
 =?us-ascii?Q?BWGElZpE79NFcd6lv58NXca54sO5+dwjeoVJ1smH6v4CAr2SmUwzCyvo/r1W?=
 =?us-ascii?Q?XbsBL9Uq/MboPD5mLl7/Rw+p8Pq6i6afbx/QSQG7j2CI97FhYBZRvww3nigL?=
 =?us-ascii?Q?T2v1rTaLHdYUFbGHVFyZ6q0zNw/M7pgrysTN/sMmwB49+0IgbCo/I0Dwok2o?=
 =?us-ascii?Q?qOArG6oKkbzklKP+bZYWyj45FUn7Lc4daNpWPIufz5i9L8TrKRbQdhUfrgZt?=
 =?us-ascii?Q?qzLFnDjPEyXsKqszNnjepOeHGC77GHY2iL3F9yGQYMw++s5u+Rk1au/pt4yw?=
 =?us-ascii?Q?Vevld8mJUTKUMaPl/BaZAc75Ko4RakxMQZth7TR/PIcOk0Nbz5nbyrnSY/C7?=
 =?us-ascii?Q?6ob6uP8YDDFHQYmDiz2To0ihD6qFqA5eh04WTp4pFpMeqqrv4zYUCHR9fERf?=
 =?us-ascii?Q?qzW9N1Sjq+ZbnsXp0pfYKJpX+dIXnty+HrsSOD3JYphcVoDtifQ4uyk7vwaC?=
 =?us-ascii?Q?xl9p69GxX5AH0IRO+AWI3qHInJyZaqJjDeM+RzB+LgWjEJW95DLhIzAjM7YF?=
 =?us-ascii?Q?qXP//4OgbiXHsb0L9NT4T4tbm0Nc525gebaYP1DSD7KbNUx9fTYPU4IUyXg/?=
 =?us-ascii?Q?r+CBj9MTrFnbtQJJFp7Vz2vDrtcwUVSUB4xIMdMy46a1jX1y58NRXx5JDDQR?=
 =?us-ascii?Q?CaBcwqJMtILZix4ZVm8vzHrK5uQMq/Fj5cgwv/0eNHZ+L7wxK5VvPcZYyiex?=
 =?us-ascii?Q?0D0B5SWh8l/2o/I7v3WJh+UYs3vKvjm/vPpJcYZ8zi2OsCCaXxbqBTdgXMrC?=
 =?us-ascii?Q?5Q/CFGJJQizARF0WUopT3mrxz09HtCcuRBbVS9pEPm4Vl+3rdZfWVoekrX37?=
 =?us-ascii?Q?zjRN13aHFxCfqftDII3Dn+xucLW0tmzsIkC1haLe9UUbqvb99AFh3/S1Oskp?=
 =?us-ascii?Q?k4L2xzkYpImMmU97Uoo17Mb7pFkM60ucFKGS8ZDQxb3St6wDJ22R1FoZB0S1?=
 =?us-ascii?Q?gChjKXBgwyYIj0eWAO5JKRP3oBS/fXs38+CDemVYzhE2rTzfIj/SxgdoXcCP?=
 =?us-ascii?Q?yRMkO58OFX247bwMVASKRvzMVbaFIHzkSZE6Ze1QSBSCtgdX8DoR4L56cdmC?=
 =?us-ascii?Q?QcYpVaf5XvCIIrwY71SF+xtj366XZe58N4V2smZZJuo/CriYYQu9hLsWedmD?=
 =?us-ascii?Q?gv1HeYvuXx8WllAhQdjFAd7bkSH9IhDbX15UeNvQlnMgW0fLsSqnymP1CEqK?=
 =?us-ascii?Q?lbu8HkYig/otcH0+Q7BQTkP4OhBN1KEY6bfKATSANkuwvX/aR7P5XtoomiG+?=
 =?us-ascii?Q?72JjQDTP1D4zPwC9ZjJKEoyMwPmMUqSoiTs8jMbKhidmdLoApckC63E56tNh?=
 =?us-ascii?Q?MyQk/Srg3PlKZAkT4LTVtOQbDlYpUNtzMBvMZZdMRyDOOwiNmMyuMlE3Nl0z?=
 =?us-ascii?Q?fu85IkwphWIoghf5DSujYEuaQTHIV/Bp904/0bteeJBGXiRDYKyjHaAF4bkC?=
 =?us-ascii?Q?fKP1CBLONxauhmN02I7d5MAopUCIRHRgIrmWJYsVj67Y6n3Mm0aA9jD2lt8W?=
 =?us-ascii?Q?eRKEFLdD0dCM3UXV0Yo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdc83ba-17f9-4bdf-cc5f-08dc72f2f040
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 02:18:11.8151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oW+fQEdD5wF67NUgKAfT696fR4rbIEKSgNcKUHExKSHY4QiRC1mVSZCAzw0xXfJiHUQuk9ZP8tVdz1y6neFkpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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

Ping ...

-----Original Message-----
From: Jesse Zhang <jesse.zhang@amd.com>
Sent: Friday, May 10, 2024 10:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 02/22] drm/amdgpu: the warning dereferencing obj for nbio_v=
7_4

if ras_manager obj null, don't print NBIO err data

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c
index fe18df10daaa..26e5885db9b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -383,7 +383,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bif=
ring(struct amdgpu_device
                else
                        WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL, bif_=
doorbell_intr_cntl);

-               if (!ras->disable_ras_err_cnt_harvest) {
+               if (!ras->disable_ras_err_cnt_harvest && obj) {
                        /*
                         * clear error status after ras_controller_intr
                         * according to hw team and count ue number
--
2.25.1

