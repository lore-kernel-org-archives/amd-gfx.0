Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119A3C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 20:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50D6611C2
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 20:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50D6611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54F956EE8F;
	Wed, 19 May 2021 20:40:36 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB696EE8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 20:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHzq970H+VCA31KVUxyOl9KbY8HCwKXXvcFSNvZBUWFwNEgvdmzopvrddUFgUbuaE/yaVaMZbEm4E/nD4WbqQoXFAYTy564YKewrdy2Co09iaBI1rDKgGbw3K5lJhyHsBv7hbrXvKw9y+BmJEaWSffGM9GQdSrrZ4Zuc+rISbtGHAdeRbxgfwNtaKZwmeeZLy0o0Xx1QmHm1o0W8vNNM05koB20KiT1L5k5yOD/ck83k96O/Oc8ixS52S9n9EGG7lg1uex1wq8FOlyzQ7fOjP/m6PMC2tEF3vdCraGsaHvbjJkOIEW1q0zunZxch3NqoQs5OreTSmr5E6qbaCTiu6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSaP6hQdESH+R6yMZHrQcDCBJC18Z6VcEZvxy+LABro=;
 b=K9AozRF78IFe0TM7s6ScMB8gd8Mz11sRQeFx440i9tpprj37GmhydbtvRWeQlGtQ1Bhto0U+xp5wE97sCdP/x9veOdVWnIgsUM7TrSB+l+IDYSTpbNQFPGbUkRxDcuOWc257VgXYQfq3jclIj94+YuShJGa8SedtELMthHMT8awlESYlREjsHDzprr+Fs3xAYYVIxigt/eczL0tJQT+hl/fo7ymZlLyqz0yIAVNFIUMUaGxLo036XifG/oAwciIuMLg3V0JBl9tQw3yn9NAYRL5zVsaafz4nhnYX6jzNt1N/Xv1ksqT45zb//bLGON3LOF0GHbJqImAtY9127vgyMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSaP6hQdESH+R6yMZHrQcDCBJC18Z6VcEZvxy+LABro=;
 b=0VXQUnYm0ItDGWJ1musQ2VRiZxW3w57i5F7nyWJw+SkUMb45AJ+5HOBYrHrvkt6RPldHypt90hW7uXScibKeFepJ3TcHuX165xPwnaFfGHauJ8oI+Urdmvfc1l5TLJV2XhUf9vW3ytStAyCjqcwU1ZS8EOMH8K6qYV0lrZAwwxY=
Received: from DM6PR12MB4843.namprd12.prod.outlook.com (2603:10b6:5:1d1::16)
 by DM5PR12MB1899.namprd12.prod.outlook.com (2603:10b6:3:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 20:40:27 +0000
Received: from DM6PR12MB4843.namprd12.prod.outlook.com
 ([fe80::81a6:2805:cf9b:eef]) by DM6PR12MB4843.namprd12.prod.outlook.com
 ([fe80::81a6:2805:cf9b:eef%6]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 20:40:27 +0000
From: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vcn3: remove unused variable.
Thread-Topic: [PATCH] drm/amdgpu/vcn3: remove unused variable.
Thread-Index: AQHXTO7sGMycYsSru0e9UPSxUYSbdqrrRHdA
Date: Wed, 19 May 2021 20:40:27 +0000
Message-ID: <DM6PR12MB4843EC792C50E6DC8B8340C5872B9@DM6PR12MB4843.namprd12.prod.outlook.com>
References: <20210519203747.2736827-1-alexander.deucher@amd.com>
 <20210519203747.2736827-2-alexander.deucher@amd.com>
In-Reply-To: <20210519203747.2736827-2-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=39713ab8-94af-4b11-a972-84c5320a1f43;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-19T20:40:12Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-bromium-msgid: dfaf16ca-1893-4344-9303-fef5789d80d8
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bc97bc3-075d-448f-ea4d-08d91b0655eb
x-ms-traffictypediagnostic: DM5PR12MB1899:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB18990FE8AC96BC414C1147A4872B9@DM5PR12MB1899.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U3mKpHJJ2m2M9eCTTSU1F7eHlWOMuX+912xUlIr8taNlwxkFav3etGXJbCjh9XS1Xv3tK9oPu6b1/NjA1f/HyL92TKksoG8gWGGFPvPb2H1x05hfyi3t0nuDd0yEpsrYEHdgYQC+5EowQSMM3a6PBFgrRqEdrZq/x+GCSkeGfgg8Aue+SZSJUenhw9hwgYmGKB64FF9shs7EgK082/aCGBQXg2vPNZnHDjZPYsSRWRSVkxmVTqUM5PR2/z78go/Z5sUVmXgRIiJLVmIWWYOtzTJvXm00q0ZJ/lywrve1beH7MkRSvKulRFfmVcixRmXaT+t9F3lsKl88pywwiSiVyKxVr/sEYu86wo2keRqFpdUBUGMrUV7BhR03wxbWgmrw5P6/lBIq1gC4M2Upn44VbLPLHPTe1EOMorRwmJ9FpETtdcYDR1qwn8LSzGDwGGOuEdvlMyigbIQEVKXJxTxgTvVbqoFOJ2ahhXqjC1O8+vAB9RWNavpDOP9SlzW/19688VJwdXfD1V5ieIzHJmOQZtceRJiWsAFTS83oD5yr/IEt6jxWY1VW24JicPc6GV2UU584PAm0FRIFKSHmRwyetrSMs/wKmu9JZruyXZJ1iUVMwxHvfZPpsw36nYOx8J3g
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4843.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(55016002)(71200400001)(86362001)(83380400001)(33656002)(8936002)(52536014)(9686003)(186003)(66574015)(2906002)(8676002)(26005)(110136005)(64756008)(66446008)(66556008)(66476007)(316002)(54906003)(66946007)(76116006)(7696005)(45080400002)(478600001)(4326008)(53546011)(6506007)(5660300002)(966005)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?edRY6WhB8VFS4LwvVo393joi60y/WMRWL8+ZMQSRG68n76XI284cYaJi/l?=
 =?iso-8859-1?Q?b522NvooDyrrZsk5d+bufT0JI/LA5z+ebDIqApdgwUJk88JiD3p3hl6uoZ?=
 =?iso-8859-1?Q?0komBLu2ezsmHoOEumWJWLUWMro1MoUxnucxZix2jBzTUKSbpkOSGxqGt+?=
 =?iso-8859-1?Q?hYvRjheihTvC4UnZjcDUEY4WquZwuXxYqJsb8DV2Gysz5AQGTUfTqR8Jrc?=
 =?iso-8859-1?Q?v3doBTp8Cltbb0vs57HCpYAS9yv8TqLNI0lECwIh0F+aFn5xsia6VC7k37?=
 =?iso-8859-1?Q?i5i5q9117e2qpagK/wZ9sM1mLTDHNDVJcHn2BfCvWTGyCxNJVJfziFWPQo?=
 =?iso-8859-1?Q?0DBwM+AYrjkKXYZymXJ7Tmd7Xk0k5HEnpilwx9vCF90IaFcc/rBjrbwFZI?=
 =?iso-8859-1?Q?dxVmDO38H723gKHZawng7l/OmI4vZUYlx5uqN1nXfpcB25ARatx8gaMv+Q?=
 =?iso-8859-1?Q?wkoKLZySNNz/w1ob5EGkyjzqXKng8xzLgpscoqbgw17TjzR9SBfpvqywkK?=
 =?iso-8859-1?Q?Xznt08g+NUkX4MLOY3Y/2uIyorvs+6yrOCdykApuXuagTv9IQb827MCNTF?=
 =?iso-8859-1?Q?q30GRuWRDOD3IlPmtqOy5ojWjfK6UkYLj/Mr2Xivn5o0fZNcjZi2I08RM7?=
 =?iso-8859-1?Q?xoH4o0e/Of4xARHj+HShD4TvDap92MTpR8A+hSV0RWEIZw5G3ZpKrNDWOq?=
 =?iso-8859-1?Q?JJiU8pmfWDeTfKvrpGCVaRs9JAc3S/JbOcYLhfuO2ywF/o0wJvotX+A/NC?=
 =?iso-8859-1?Q?zwR/DSh4DnftvNrswcdRAXGMFkFhVkhsuf2eu0naGgtk7fJWSVpzJ6HRLX?=
 =?iso-8859-1?Q?bWQXc/vxsat92NIBkQauCrnKTeMBD7iDxaFuAMlBZlFEwZyvA+sh/Gsfbn?=
 =?iso-8859-1?Q?LB3Cf04nTkZnjK9L15/PV7qKOtO6OnB+KHcHNHX0FNSbe4sbrhY1NJ1mJJ?=
 =?iso-8859-1?Q?csdgGGvi0MzvYquzUTc1FAQdFQhiuS7reMC7snrat8ZEUHoQyQ8rVoWgN+?=
 =?iso-8859-1?Q?XZTFC24W1GWvDq0NFBORHdNHUdlf//0q7FDor15kr54ompSSyfqsAQHN+G?=
 =?iso-8859-1?Q?iTpO58sHRRyxcew6wG8HxjLNa0v1nnrYYj+sA/ggrRTOoiBScSOWCSns4j?=
 =?iso-8859-1?Q?7MMFWueckR48IF8YKxUHcA4dYsi27VNMB2n/myynlTX7iAGYZqLfJEgX7e?=
 =?iso-8859-1?Q?Cdh3aw1prZGgX4Yh8ihAJEHOKXYLICIr6bZRWXaOqhcYYynShaR2nctIpX?=
 =?iso-8859-1?Q?IeATPWxl/k99+HHcHWj1jWd/eLhSNqRPxSCkjnNcTkLCt7nkSqvyKRZvFl?=
 =?iso-8859-1?Q?iRmM2Kza0nLAGux7+HD4P4FtyIqaQZT6jYoVKZs3Zjea4BtAp4jBgilsK8?=
 =?iso-8859-1?Q?okgHsHCdR1?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc97bc3-075d-448f-ea4d-08d91b0655eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 20:40:27.3544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p25a0++ByAkL3VKSvwHgV4WT/K5u6nS1hGe6cOLUbkaljFZLsgWFX7eibyozkp2/l0Zf9wu5RHIskEO3lePZCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1899
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Patch is
Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: May 19, 2021 4:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu/vcn3: remove unused variable.

Not used so remove it.

Fixes: a8ccb542539ff1 ("drm/amdgpu: stop touching sched.ready in the backen=
d")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian K=F6nig <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index 2d67caba9293..946335d0f19c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -381,7 +381,7 @@ static int vcn_v3_0_hw_fini(void *handle)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
        struct amdgpu_ring *ring;
-       int i, j;
+       int i;

        for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
                if (adev->vcn.harvest_config & (1 << i))
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cboyuan.z=
hang%40amd.com%7Ca747b6a8dba74784461508d91b060cde%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637570535079254026%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DL=
oAr7Oj6W9AWSMN7r9S%2FmdzRU%2F7ZfACifvY3681yFhw%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
