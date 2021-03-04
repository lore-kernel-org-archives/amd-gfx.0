Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7C5C433E6
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 19:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A378364F52
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 19:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A378364F52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B9D6EA6E;
	Thu,  4 Mar 2021 19:42:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58FA6EA6E
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 19:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShW8TcTgQwiiuErLj6YS32YwLf9JZeFwdhrQw1ar4wznb6/iLMB6+FSWtttEGp3rT4t3NmuelDZ03rn80xEY11xnJ3RNoGFjH6wsIoUV4cHMRgl52cd4eGQeEL2NYHNYNu+7UUrGvM74apqxPtprnWnPLptHrVt/NLezd44RU2y2E6tG5/brBXPSuati0FV45uReA2bVG02SxdkifuFjbAWEIgH/pIgaANOHTcW4Fh7OZFZzmVgLWjd/DxrohSrFkaC9/3andpg9+Iml/mpMLg/OejoaiADArxoS8O3xLEjbcgu+uy4mowgkkvfJpQMbhiTNKMYgUQeMpA/8OTpDwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8d8u9kuaV7oY/YFmwuOSPVYybpunhSxR5xt3KFFQXoc=;
 b=H0dmcu3tuWU/1qes+w8inQ/tapxhEbZiGy5+mRXrph1V52fOlMwtHRbBj5tsGTEPDEjbJWrT2zBq4saztfavzIVsmSvGYgKTuxaD42vj1d9nQV2ypNQexQyLXsbj0rykXHZEbJ3hvhf7tI2+vgD4AEg+Sv1i8JLgBpHyWC1PeJvYeoa9zTaVFV0vhV4d4BmjzHpmDph4NbNQg2vQuMMNYBO6s3e9mlJkdEzuPw2AZr7KuohxNR5N3bQqdJHq1eOfKnEqzQi+R7DploYi3TWd4rcrFhvt49aYOjLyv1Qf7wdyQVq+dh/SXuguAUg5C2IJ8ya2W8Z8CPG4zF8vQKNbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8d8u9kuaV7oY/YFmwuOSPVYybpunhSxR5xt3KFFQXoc=;
 b=kgFsa8BMWN745ywhMIekpQloWj+YiO9jY18ZZuy9/CkhUSZqUf5SmlxtblKykPl85y0M8btoyVdA/1KPyuxTDbPSqGD0wk9o542+K0dCN4JZLjFdGFbZxgpulfA8F7/uWxvzQJYYYXL4GZOprEZCX3k47DvaqCnD/H96hVX7se0=
Received: from DM5PR12MB2551.namprd12.prod.outlook.com (2603:10b6:4:b9::16) by
 DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Thu, 4 Mar 2021 19:42:23 +0000
Received: from DM5PR12MB2551.namprd12.prod.outlook.com
 ([fe80::40dc:f71f:308c:fe79]) by DM5PR12MB2551.namprd12.prod.outlook.com
 ([fe80::40dc:f71f:308c:fe79%3]) with mapi id 15.20.3846.035; Thu, 4 Mar 2021
 19:42:23 +0000
From: "Ma, Hanghong" <Hanghong.Ma@amd.com>
To: "Ma, Hanghong" <Hanghong.Ma@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: add DMUB trace event IRQ source
 define"
Thread-Topic: [PATCH] Revert "drm/amdgpu: add DMUB trace event IRQ source
 define"
Thread-Index: AQHXESzvuVYX6lR0zkqejahDSycg1Kp0OJYw
Date: Thu, 4 Mar 2021 19:42:23 +0000
Message-ID: <DM5PR12MB25513F0693FE92AB00A39AF3F1979@DM5PR12MB2551.namprd12.prod.outlook.com>
References: <20210304193049.3368-1-hanghong.ma@amd.com>
In-Reply-To: <20210304193049.3368-1-hanghong.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=13f9cc64-91d0-4615-a8b8-4db8f1134baa;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-04T19:35:02Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7cf7cb43-9a09-48d4-26c3-08d8df45a21b
x-ms-traffictypediagnostic: DM6PR12MB3817:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB38176A9CC8F913173A4A7052F1979@DM6PR12MB3817.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZqTwp2np+A5KFtPs80hjhc1LBpCR9eG1BSw7wm2Le7JRPB0TTFa0QShfqtqW2TG+Kwr/RjzVlgMU8MS9f3w/Qe1wfFkCa2lQzNxYNRaeO9xP8ViBEEi7qIuoXlOkj6hRTjC+yDKiNk/vZbMS/DEDKEAUULfPD372zCGvnKh1eCqObUE1qTWQUL4+ipHoJPpfsY7PfElw7/OBMuBEf7XPEJTAbNMVPLfo8wMKPSz6uL6Nk0803OEIEeVxG97bvt7/BvAZkeeGIqN6Li1UkjegxCgdLcyb6kJ6jnTnFkhNCH7XTBU5xjqueMYZGOyhqaRHXGLXmEjIKSQZTrXLbhXC4TB62cJ40NsLxv0jXlTFJN3j5f9O7TUrD4DMqsGaAMBeZp/gr36lXEvD2LtaKbY0tkXu+HLF1kE24C6pIixF9OIvYluLucnVYfdPErAeTu42+1Py+ox3gZJvsflK84SlwI0h9fz2W5Whet2/0PO3qP3K952E8B6nJRe+EpIdEVZs/wSOkpK1tXQC59pnNKumjw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2551.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(26005)(66556008)(86362001)(83380400001)(52536014)(110136005)(71200400001)(66446008)(478600001)(64756008)(66946007)(6506007)(53546011)(4326008)(2906002)(316002)(5660300002)(55016002)(9686003)(7696005)(186003)(8936002)(33656002)(66476007)(76116006)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zhQkGu7zblr8yeQI9TiNiqDMwTvUTEmLkAHks3YWK2Bbmx3xTQfNI6dVBIqR?=
 =?us-ascii?Q?dDJEjrTbrToCf3Mj6gzpSU1hapgyPQhXOXHzHC4oLgZSw6f7cjW9LGdKxHGO?=
 =?us-ascii?Q?lt3cocNw/yteZRunLM/QdwmpHk27GPJ1DYc6nkbgfaAP+UnMhC8URUbTRzu+?=
 =?us-ascii?Q?IXMdKLwsJGdL3QJiwsTkY6uzpojq8GWcmz8fe79820/wwP+gXQL85lYJFFea?=
 =?us-ascii?Q?FCfkYIxsmDKPVxl3VcelVKptC6CD+7Y/dEqzNmWWT8Bk+w+b4pSdvVZXpF3l?=
 =?us-ascii?Q?zDPlhqI4dSlyUtaf2IOg0dKky1b5a1PLjzayWBl7yXclzbeOMOdSAjZhG6CM?=
 =?us-ascii?Q?GM71/gbgoCvzv7wKHBDTEkFPNB4iItUr8ZzQbUlzs65zxTGs1/+xGQdr4NQH?=
 =?us-ascii?Q?ntrdTeqd9SCPU5aZW6pPf3HIu4nZYpi3Yycq9/uBXKcI+tcfOQOpNzHUSyVX?=
 =?us-ascii?Q?3qn/K4u0Gp6ovDtTXFz272QN3+w/t99qEw9gbZhFkgjiLvVXM5FYJgz47c3T?=
 =?us-ascii?Q?pUktLIcQ9lI2ZEPosieQdCDCosbDORyWcsWrja1HI8kV4lOqs46+Xbeg7mDP?=
 =?us-ascii?Q?ppUOc/c9ABkQa4HHpNTV1uUfYTcxn8/v3XITFHVGlGqUTQjc5etXf7TkZgFv?=
 =?us-ascii?Q?KZ4GNJfQTHWJ+Vm89cIToCoKKoM+a3KXBOdK00EM6JM8X5XvJ4BzSNk0UeFG?=
 =?us-ascii?Q?b1hDySV/P3aT8Rq3dzVMkKq1B+iy8J4h7+MgtgfO+8STHzAAvMdYAsMuORAd?=
 =?us-ascii?Q?E9wx51JJjSn6/VZUhO7MFDVMTS9nrF4uBBG/kCB3LCg2DRi/H0hOpSr/JzLV?=
 =?us-ascii?Q?2p2zCmc0GMMB6UM8Yiqezo/no2kAeV+35hM+Wh4naGX4jjpXPuoVEO/cVC7+?=
 =?us-ascii?Q?t5lSk4REROkQNt2AL0P+8N/OUWQGA3fKR5lPEKv3V1bON3ABtyoFLmSyV/p1?=
 =?us-ascii?Q?SqJOt/DRErt5DjR/sthKum+YGS5vJT4xHYy2hDVjMdsUjxT1DGgZdU+B3NQL?=
 =?us-ascii?Q?QCp1QBGX7OWuEA9+syHTulfic2oGmbIpnkMk+FcCuXeFvKOgKZXM/QA/E4e+?=
 =?us-ascii?Q?t02Q+n4/a6fFujR1OmYp23xy8Jgkw+1bKwF7Pd5Z+OY9SOOkr58awkfmE2yg?=
 =?us-ascii?Q?zjqE7nE/FOsZEfx7KbBqbNo86IXk8GvuQ6zYTl03pSqotDWIsSvJ6ABjviRZ?=
 =?us-ascii?Q?z1nNSo72u3nRysozu980+NJez5al29UMhAT7ZiKBuAbY/wgBvZK7+rNYmEJw?=
 =?us-ascii?Q?TBvWrAcToEXJ0bKn/wfpc8jbrc1vSkUxKx0wKYRSKw/nxCD6kOsOp5EFEE/Z?=
 =?us-ascii?Q?ovf5WU9fogPul2/Dya7fsV+c?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2551.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf7cb43-9a09-48d4-26c3-08d8df45a21b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 19:42:23.7251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MiBrRuCLlneiIiaURO38HSnZYx++FYfAfVPbdrJdghSFCMLDYWq1xc2MBRkwp8ExNe5cL53DlliWJeFZvFVoyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3817
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Apologies for the noise, and please ignore this one.

Thanks

-----Original Message-----
From: Leo (Hanghong) Ma <hanghong.ma@amd.com>
Sent: Thursday, March 4, 2021 2:31 PM
To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Ma, Hanghong <Hanghong.Ma@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: add DMUB trace event IRQ source define"

This reverts commit 3590cb311815b3f82af04e2ff1f182ca919af3d3.
The patch is applyed mistakenly before code review.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                       | 1 -
 drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f01b75ec6c60..1624c2bc8285 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -912,7 +912,6 @@ struct amdgpu_device {
 struct amdgpu_irq_srcvupdate_irq;
 struct amdgpu_irq_srcpageflip_irq;
 struct amdgpu_irq_srchpd_irq;
-struct amdgpu_irq_srcdmub_trace_irq;

 /* rings */
 u64fence_context;
diff --git a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
index e2bffcae273a..ac9fa3a9bd07 100644
--- a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
+++ b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
@@ -1130,7 +1130,5 @@
 #define DCN_1_0__SRCID__HUBP6_FLIP_AWAY_INTERRUPT0x63// Flip_away interrupt is generated when all data for old surface is returned and old surface is not used again after the surface flip.HUBP6_IHC_FLIP_AWAY_INTERRUPTDISP_INTERRUPT_STATUS_CONTINUE17Level / Pulse
 #define DCN_1_0__SRCID__HUBP7_FLIP_AWAY_INTERRUPT0x64// Flip_away interrupt is generated when all data for old surface is returned and old surface is not used again after the surface flip.HUBP7_IHC_FLIP_AWAY_INTERRUPTDISP_INTERRUPT_STATUS_CONTINUE17Level / Pulse

-#define DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       0x68
-#define DCN_1_0__CTXID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       6

 #endif // __IRQSRCS_DCN_1_0_H__
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
