Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57221C4320A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 05:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC1360F91
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 05:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0EC1360F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB7B46ECA1;
	Wed, 28 Jul 2021 05:53:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 063A86ECA1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 05:53:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN8C+FZWFUAwAcwPS9+ybaoLmgVoSmabetZYt/FXBeGodf0V9+MqI0RseSszuEFGbywiWEszg/RM7f6kSjXo/n02NOCFbZS7bhcxaOGRYOdayKEnTNCbTE6rjD0aOWxG0nlKHzIQOZYZiN3oLwJTLfZuMZD/dEzp1iGkSoKhRvtqrdCEgs7imJ5LvfJaSa6YQnYZZi43B808OKsvaBr+qjf6Wtm+3JcXXbcdyWeyr4BhP8qVsYEq4XGcRSV11jc5rHdbztZVXPDeHSM4gekXr3spk/0pqEidU992P8qTvnyhg5oK6JQYJ/N7njwIF/O58D6d1o+1fY/s2Mrvu2aJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77StIaRdQYFaSGhIviktxTL0JbmNzzZ/yMlhCgX0f3o=;
 b=VxAEoPoahCKDuTYngYk90M2Ml4zVRHE4dR3tEIdIWP5wVULjJ+mFO0uhOEJmO+QJnmRWhuLHD0sfMe1RsoEBusvjLW30uJFJOYy9b4DafXXmuy0FQQop/doPpur+9HDydJVr3UX0O/Y3BA3MlE0tOW5wTzyMEV62nbQLM9aePTwd7KFgy+Hga38MHAIpevCWEL1SLodu0TITI9oo5B8unhUNFoK3+muV1pnAEk64vH6g/u8xGFp7R+9sumaL+P/c0NjK6PQU/PT5bOLcibYtlZkU6dyXZgoU13jyjJtUCPpSZ4CNNo137LN/7ys+TzMW4Z3qOmi0k7hIG7Mfwx0j3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77StIaRdQYFaSGhIviktxTL0JbmNzzZ/yMlhCgX0f3o=;
 b=vnHPF2ftowHK5xMCff5S8bbpExra4HWdibB2G+YDXBPZLQkzUOaBf/HvQRNS2LLf/CkjBGHSV+/MV0tXC4ahPI/TrmQDtEs9hpGCN/O7SV66qv376OdqRaX4aLnHCy+o60S5OHida9BlgDuUGxYHMLFfZrBQTM4fFlkotzGoMzM=
Received: from BY5PR12MB5557.namprd12.prod.outlook.com (2603:10b6:a03:1d4::18)
 by BY5PR12MB5526.namprd12.prod.outlook.com (2603:10b6:a03:1d7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 05:53:32 +0000
Received: from BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::303b:d360:bb4:113c]) by BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::303b:d360:bb4:113c%3]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 05:53:32 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix the doorbell missing when in CGPG issue
 for renoir.
Thread-Topic: [PATCH] drm/amdgpu: fix the doorbell missing when in CGPG issue
 for renoir.
Thread-Index: AQHXg2I2JFn/r0qN7kOgfnm+8guLr6tX4SfQ
Date: Wed, 28 Jul 2021 05:53:32 +0000
Message-ID: <BY5PR12MB55570293C12B5417DA4C7B9BEAEA9@BY5PR12MB5557.namprd12.prod.outlook.com>
References: <20210728033935.2492805-1-yifan1.zhang@amd.com>
In-Reply-To: <20210728033935.2492805-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6a696f0e-ede8-4959-a47d-ab3eec779502;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-28T05:46:50Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a58cb065-80d8-41da-f7af-08d9518c080c
x-ms-traffictypediagnostic: BY5PR12MB5526:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB5526B188E4FD6274B33217A8EAEA9@BY5PR12MB5526.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sL33tJmKXUaYKogsN29czPXHN77kPHtMJELn5ntlGar8D5bX56IwXXRPiDb6kxRdOtjHif4v/aHQRqhRsEn6p7aPvrObRSy78dVKS8VqUS5Mpf5g+x0842C7VuUPg6GC1q6spaAHR/pFpeiR3MlawD90kY7tRPRBinGijiQ11nOYlwtCiSAKzl0A+Meh3mwXFeAMjZNW8Pjoq6h22sUZeF96yMWOoT1oYQoBB1iFKpSZh6CGZMyfBhB6WbwRUHfbJ9bBg13ABQ7/uSfo5YTwIHo3Zfx2uAHUSBXdLb5fMXtKmbARHSDqFGZXzbnqkaEPIcaeOMabQPJe1Ismvb2/qS63QZYenvt+fgOt4jZtHiNhdXR0YbiBkYuhn8AYMoHAFvTvT+HMUl/+lBYgc6Y6YrurbAAnZU+bhW+wEEQRm6Y3cdN0DQ6pOY+d3jj7TNysjDUWTK+JToRhwIw7JRfDbG61pgpJjaZxjXPYLnh+H/bzNWdfRALOS/saheLQ65rQ9d8zRlTz1l4s1K3ajgh8J3AdIGtKON/My8NxOBzDEYpoKwr1V7JUoXqLFaE6CgYGOG4pkA67NZqwBcCE2iiMfK0R4SR3/c2ys7qSSZ0MPJs/nUPNP3OGeir74Lf+HXiTgdPAjetBBwWDEQUhINj+t7R7r/jYOKebZ0QNursoG4NH+W6AJRQYlAlgViKqRz2qnKxb8x1y0a3gp9I9ddyHbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(966005)(83380400001)(45080400002)(76116006)(66476007)(64756008)(2906002)(66446008)(66556008)(186003)(110136005)(66946007)(508600001)(316002)(8676002)(26005)(9686003)(122000001)(6506007)(52536014)(7696005)(38100700002)(55016002)(71200400001)(86362001)(5660300002)(33656002)(53546011)(38070700005)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WCsvPUvwcAKrVjEldfGZAF9QeiRJnk/frAJxW8KTulTqWDQxrxH4VVRMuIXs?=
 =?us-ascii?Q?KAbWybX+26auPRzrV3TNK8uNvoz6upDpNgjZPezn8sEX992EKEqp6lstF+rT?=
 =?us-ascii?Q?qkL20O4MugEJfGbnBPjcOiMj/REg16lacSiWYSSx5Zvi4vePmijJnN0xkN/U?=
 =?us-ascii?Q?DVMlYu50/Fo3GO4VXDRtbwy63eTuxJPlrhgPqHqiUE7cq8YgeHLcsK/XilwR?=
 =?us-ascii?Q?DkNESq/AN8kXX3CtXrqPNlTZcq6Ru158qovVupPMGff4uDaQCGqcEA672Uj/?=
 =?us-ascii?Q?gf1/mlSuDgMEu2BNuPUgg/GrOgn979hQ0ImHJJJ5VphRaq50lCGdczgz5r8j?=
 =?us-ascii?Q?2wueb0pbSdbQLZ6dYaCJW1Gh667DpW+7zJJNhL1ZMnwJYtupHH2uKGBs1apn?=
 =?us-ascii?Q?betnKde7/Yws1R5M1vXzZ9yq/zTLzc7qWgvaRhunmekQ0IbpFWnxt797iqhZ?=
 =?us-ascii?Q?LABxreO3lEs58rOrBhap8jh4pmXZpSBZG1zdY7dmSIMHoKOIEmMwmdKK0NDz?=
 =?us-ascii?Q?FiaAdc2VBJzkGdLo/9UWKKPdlolngUMO8d1NiPb7YXV/KLQa0cLQbVJXhM+s?=
 =?us-ascii?Q?Nj1kIqRujEyo9a7cLebQD0g/E6nCeUwpCz22Sn0371Gmslm/SxW40VWSjHnc?=
 =?us-ascii?Q?uG+FbV2sY4nPvJeO3NPI8z+hPfoFpYhdekkr/ZuXsJP0UlKyHuEHPF+B2U2h?=
 =?us-ascii?Q?r1t3GYGPWWTVRlja5P9++JQVlx0gJjXpatfcyeAp/rz98Ghz3pgqsfOgUpSD?=
 =?us-ascii?Q?E+ICFFamKfxmOO9RMZjVn46z86bWfsxFhqCUOOMJyhe8fdVKRK8xw8Ou5Zhv?=
 =?us-ascii?Q?0A0Jtto+RGdLpKx1dSJ04c/2kMETrpBE+8Zechxvr7Sw6IUiyMBWVnvIuPM4?=
 =?us-ascii?Q?yqLj1JCArAg2ISHbzIgCQmy6EcWG/lek8/fRiqSmO6Nszouflecp+CAqDWbz?=
 =?us-ascii?Q?/qwZW+TKtyUkMMKMcxjiwurdUbQAtqnZFm4YuinvU+zt2sDwxy9lYUqltx8/?=
 =?us-ascii?Q?UwBKdBcQsWgMQu2ePecGJtlLOadaWEJ66RJjGHH1f+D5DmVgk6/XFhCVbAmQ?=
 =?us-ascii?Q?pg+u8X1CWcXrwHZYXOOvmsVJULGrpYM7PSAADRFP8jepI6VvbNNuTxssM0RR?=
 =?us-ascii?Q?VQbEs4sfVSTiCIKq8NHHWzdUVCHjmQYUMeCiL0N+eTRDOjo6hNIQ07zV6/xN?=
 =?us-ascii?Q?04vE5MbPJLUDAfo7gqreW9f5HG+9OfauRcC/wewxS9L5V+SFJzyTZ1VschIp?=
 =?us-ascii?Q?dd9BkyD/fpK2hadOOkKGAYniOmheLvpSCw0uZtUMJsLBFmF/OoGjECJX7883?=
 =?us-ascii?Q?7RA5MFy9ogv8bODLvLlhSliU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58cb065-80d8-41da-f7af-08d9518c080c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 05:53:32.0580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9XOHtAxsc34X7G9yEAu/Uh6MO24MzYbSqemY1iRtY1WSWslCVCHNjbVuoC4ObWHgIGNSWehT9sEBLcTkN3U1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5526
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

A coding style issue, "Do not unnecessarily use braces where a single statement will do."

Regards,
Jiansong
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zhang
Sent: Wednesday, July 28, 2021 11:40 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix the doorbell missing when in CGPG issue for renoir.

If GC has entered CGPG, ringing doorbell > first page doesn't wakeup GC.
Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround this issue.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 03acc777adf7..61a8583f02a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3675,8 +3675,17 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
        if (ring->use_doorbell) {
                WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
                                        (adev->doorbell_index.kiq * 2) << 2);
-               WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
+               /* In renoir, if GC has entered CGPG, ringing doorbell > first page
+                * doesn't wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to
+                * workaround this issue.
+                */
+               if (adev->asic_type == CHIP_RENOIR) {
+                       WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
+                                       (adev->doorbell.size - 4));
+               } else {
+                       WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
                                        (adev->doorbell_index.userqueue_end * 2) << 2);
+               }
        }

        WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7C967ed9eb56a940dbce3208d951795733%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637630403878593524%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=hybuiWZ8M%2FGlBT9IHOIVRYvYulI5Ze8Kt51YqHXLihw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
