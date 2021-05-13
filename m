Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5BBC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 11:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866F061176
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 11:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866F061176
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CEFE6ECFE;
	Thu, 13 May 2021 11:50:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 952E86ECFE
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 11:50:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8olmwE39P9+g35/5HOhRP1PhUqkYXHZZ1SKPH38JbA8aVss37ySxG4emza9vfc86O/Ue22TbZk4awg5GIJYn1xw1g97e/7f7h4ulyhPx1IJS6UM/GWtvAe6SsvnuZvoLX+RVzpUXbg00BAFXUrIJVcbHMPtxYCdNGVG36q7YT7b+oOIl6lULqUzTZ0oP4to44e+wa4QX3xKTkpnWQhEnxDGDEmyadVwhXR22eQhi/yORfBZSA9A1pNVdtrQMYdydzJi3GgB9FHKcYl75ZGwyGs1RCjGJUaXA9eR/7I8shouINx11ukp39yNGOPlJvBa69LR6pTb2hSzl6ZW9iMb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwkHkJ7p9E/caJLFHlHjR6xSQJh3dlv7xyDqCYurbn4=;
 b=jfxDr5AdeXa7Gxy+32QDDeVuGbpFdvwAqBccYWQGFBFKIxA3qfnAhKug5HzXg9Kh0L9pSiG2p5VOQrDcuDHKqTUC7id0D+dDw78Wy8L8lRrVCtdDFBHNOwdmihWsnDah+8BAIWX7yqoFkzH2gG3hLvkeM81RwXTPncqeY6vuv13YW/bxd2GXwbS+iMj9dPlikC5UKl/tLVDC0ZTfiqG5L0a9LCeuLvWxwi1F6V9JLxfOiwQJ1GHO+aaM7W6bQE+OGB4lbbfr8ml8dm1UqmEo2yEb0E4QEW6UeADQxlecdP3avU3W7xHJy88FwLHnCbPI24Fp7OIeLDxaeAbwwqgP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwkHkJ7p9E/caJLFHlHjR6xSQJh3dlv7xyDqCYurbn4=;
 b=BBNy2QoMahjWgVwaeV15FPWRUSq/VeIQKDNeBaYroadFraUDe8c8XTQMHVvC7l4xRPhumn9QaAWncjtHOZILkVMDzvStMj/dvNMEzA4/TFRqpbpctO86wHe27FTe9k1szZ/cQT9OtMv4c2cxZqpWuP0hwk0VQ8x971ouKqSz/FY=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 11:50:45 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::c9c0:c016:885f:529c]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::c9c0:c016:885f:529c%3]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 11:50:45 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Complete multimedia bandwidth interface
Thread-Topic: [PATCH] drm/amdgpu: Complete multimedia bandwidth interface
Thread-Index: AQHXR7iZQANhF8iJmUum8je076MNvqrhTJWA
Date: Thu, 13 May 2021 11:50:45 +0000
Message-ID: <DM5PR12MB170882F26F15E2B7E67ED10884519@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20210513051949.6846-1-bokun.zhang@amd.com>
In-Reply-To: <20210513051949.6846-1-bokun.zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-13T11:50:39Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=15eb1269-13ac-4a81-9c57-856069bf7aa1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: My manager approved sharing of this content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 952ccf03-3dfe-45c1-275f-08d9160557e9
x-ms-traffictypediagnostic: DM5PR12MB2504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2504944AD967D960787B9B0684519@DM5PR12MB2504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QR17E76aD6e/5WuTTIKhNQvshxahLNPehLO2zFBdq8D7klbsrifNvzyNYnLX8+o1Js5VJbjYjTvZnO5VzWJZaWNg/OTMwz4OMk+DxeoLHWAQZNXyVFxJkCDXp334QfgGZv/ZDGfaKQq05yLhQER/YKB+MtfdfFtheHg7PGbQ4aXMzIsZfvUt1E8CYbfa318JuwgCxvN8AU22BcSF1ybW9OTZWgIVrSExbwloMGslv1LgjIvWVthUT9x1NDoiy9Hfll9D505uVgRS3i+eXvwMZM7RG8BIWuQRYyRyIS/F8AkIzPpj1pmzayHDAplQMTa7LJ9UqVpx2wDYh7KuTyanV7k9LiPJBny2A92mYCEiki1ka8a9Ghh+HayHppjNpizGFJuYb+ZFfdC1EtL0wQTBXc68ltyoWfezjq72tscyt6DiZ2feXQyQmfSpXVSEbUVRPk55vj4T6bLLhzVZHxWvjTsPM1AtHfEP6Sz2fluuF+FUsrw1n544FqDBi1sGV3JOFRt4NYKXppPTJDsOwKsQrPgLJrqPaFcqLCrbSqE/qJJXHnOf5qlC3KPSaYtjc+Podc5ODvbY62pTxNFhV26AgYBF1Or+dGXjux0kLrJn6rioizYiBX+pr1wrXTw17AiP+S8UdVjMBbOuyB8KyisYDg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(6506007)(8936002)(7696005)(71200400001)(86362001)(83380400001)(52536014)(5660300002)(76116006)(186003)(316002)(66446008)(66556008)(45080400002)(38100700002)(30864003)(122000001)(9686003)(478600001)(55016002)(33656002)(966005)(8676002)(110136005)(2906002)(26005)(64756008)(66946007)(66476007)(53546011)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7mPaP0GEo14jiZBGuYWnQ9mAYOLAN1/KXSJKz/2fFCBUQ84i0e+0xBWFvTk2?=
 =?us-ascii?Q?WjScpRJLJLxALZe9aVw6NLd3c8LJDJjjfaqoSZnQB9U4vNXxufqdqRzq32Ql?=
 =?us-ascii?Q?/4vH3GNHYUsxr/F4hN0raAbe2FLFRTFHrOJ2/Qi1CezPrhh8w22gQ2R/6iGT?=
 =?us-ascii?Q?nVV+S6OWLjR5XE9lUB/IOKTJwZnOT0TPPIY1vy2DEfMzXfrwxMV3S4brTqp0?=
 =?us-ascii?Q?u2MQQ3a/Ow9Glua9jgeZSRYE9YJ2j2F1O9d6SB2a0VfRf6O3f60LmyEEQRGj?=
 =?us-ascii?Q?ODBN3zjwd2R9Jf+C+ZhCv6cNtLI45Nwrsj2EQCLvXg5Ufoo8kj248lQheKKi?=
 =?us-ascii?Q?5Vpb/sPbh/L/NIT8Ehe+faEPoL0yeFFq+adiQ/yJ16sczEs+BTxDSjQ3DrNM?=
 =?us-ascii?Q?K4b1PIkmfb9HAPXiCeUMvizM9ZYfe1CVFsgSD1Iv+c+7TIelqwgraSO22DY/?=
 =?us-ascii?Q?lokxWbNud2+YdEKz2Lx3nqlnfpuT37pSHmqFCz43mYV1sAr8GEGNXjWzpKfg?=
 =?us-ascii?Q?mstwqaM7Iwa9++v+KbzHo4gZyEaCn3CBQ6PqWNJLaE4AZOhh4ygrBe0Cc8FA?=
 =?us-ascii?Q?36NI1nyHRDzd5c3p975Iq/6u76RXFyMnraZShM9V59qZxvlGcpZ5oQZJeeun?=
 =?us-ascii?Q?RgAcxQQw5BB/X5kI4zUlgm6/d4Rc3Rs2Zt3/SBMv/qGMpXuk0BojqmEBamta?=
 =?us-ascii?Q?2+KWsPGUebTPlmwJf8TEOfwBRP411+1MHUrxJqOqqopni9IZ7y1hNi06wOEs?=
 =?us-ascii?Q?1TLKJ/wROsnH6sb4UsamzR1lFSDOZ9wfanJDSk4f/wW42nuDBiG8xdNddfzl?=
 =?us-ascii?Q?YQZhuewriWryx2Dx1+fQl7EQS4OdCvKFe+jpYUo7JOVUQal8a+KWk5Dmq+el?=
 =?us-ascii?Q?4ZvZqx49AHwJCuqT2LWWV5t8xomWKgPIVU1CNHlfKLQt6HNLVV4+XD98+23Q?=
 =?us-ascii?Q?6oc7sGzas8jFLRiwXcZaH7Peln+1SGxj43jIFDzenm57xvOQtCvEAqpIpRe1?=
 =?us-ascii?Q?okzFIW3G3y8CvXZEwZk/26sheBKFB5ESA5kxu8Re4TtrRILcmlWZjFq6+UEX?=
 =?us-ascii?Q?jjACepJ4TSsHfTaq5hBuEpDxenPkLUySONP/BAKyfeP7ZM37dKpHrvESZ5Pb?=
 =?us-ascii?Q?/yfGc6U2LqICSWLTazS6xxffFZ13fuQW9l9+qy77C2n7uh2W6sBlqhBoBuN7?=
 =?us-ascii?Q?xBNZ55qEdD1lrHFgbMDt6/OeVVKJFe6pUiDehujmPYtn8N73OUJf+FrEPwyM?=
 =?us-ascii?Q?vDlqcYafm4QoCJ0RGeWV7FhnH0r+ZvGNHNk5QaT9uuPFI/50P2GqN8kPUCQG?=
 =?us-ascii?Q?Sgag3SNIvPDvjwFGBKGa39EW?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952ccf03-3dfe-45c1-275f-08d9160557e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 11:50:45.3361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhwLLxo+TH1geytw7AK++knY+vS498b0WmKsncERLF+tu8Gwou3XRS7OT5QMu36W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Monk liu <monk.liu@amd.com>

Better get  open source team's RB as well 

Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bokun Zhang
Sent: Thursday, May 13, 2021 1:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Complete multimedia bandwidth interface

- Update SRIOV PF2VF header with latest revision

- Extend existing function in amdgpu_virt.c to read MM bandwidth config
  from PF2VF message

- Add SRIOV Sienna Cichlid codec array and update the bandwidth with
  PF2VF message

Change-Id: Id0cfa2e1adb7a097997d53b34d41a6d36a390c00
Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  56 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  13 +++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  54 ++++++++--
 drivers/gpu/drm/amd/amdgpu/nv.c             | 110 +++++++++++++++++++-
 4 files changed, 226 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index a57842689d42..c64e583347c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -432,6 +432,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 	uint32_t checksum;
 	uint32_t checkval;
 
+	uint32_t i;
+	uint32_t tmp;
+
 	if (adev->virt.fw_reserve.p_pf2vf == NULL)
 		return -EINVAL;
 
@@ -472,6 +475,27 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		adev->virt.reg_access =
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->reg_access_flags.all;
 
+		adev->virt.decode_max_dimension_pixels = 0;
+		adev->virt.decode_max_frame_pixels = 0;
+		adev->virt.encode_max_dimension_pixels = 0;
+		adev->virt.encode_max_frame_pixels = 0;
+		adev->virt.is_mm_bw_enabled = false;
+		for (i = 0; i < AMD_SRIOV_MSG_RESERVE_VCN_INST; i++) {
+			tmp = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->mm_bw_management[i].decode_max_dimension_pixels;
+			adev->virt.decode_max_dimension_pixels = max(tmp, 
+adev->virt.decode_max_dimension_pixels);
+
+			tmp = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->mm_bw_management[i].decode_max_frame_pixels;
+			adev->virt.decode_max_frame_pixels = max(tmp, 
+adev->virt.decode_max_frame_pixels);
+
+			tmp = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->mm_bw_management[i].encode_max_dimension_pixels;
+			adev->virt.encode_max_dimension_pixels = max(tmp, 
+adev->virt.encode_max_dimension_pixels);
+
+			tmp = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->mm_bw_management[i].encode_max_frame_pixels;
+			adev->virt.encode_max_frame_pixels = max(tmp, adev->virt.encode_max_frame_pixels);
+		}
+		if((adev->virt.decode_max_dimension_pixels > 0) || (adev->virt.encode_max_dimension_pixels > 0))
+			adev->virt.is_mm_bw_enabled = true;
+
 		break;
 	default:
 		DRM_ERROR("invalid pf2vf version\n"); @@ -744,3 +768,35 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
 
 	return mode;
 }
+
+void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
+			struct amdgpu_video_codec_info *encode, uint32_t encode_array_size,
+			struct amdgpu_video_codec_info *decode, uint32_t decode_array_size) 
+{
+	uint32_t i;
+
+	if (!adev->virt.is_mm_bw_enabled)
+		return;
+
+	if (encode) {
+		for (i = 0; i < encode_array_size; i++) {
+			encode[i].max_width = adev->virt.encode_max_dimension_pixels;
+			encode[i].max_pixels_per_frame = adev->virt.encode_max_frame_pixels;
+			if (encode[i].max_width > 0)
+				encode[i].max_height = encode[i].max_pixels_per_frame / encode[i].max_width;
+			else
+				encode[i].max_height = 0;
+		}
+	}
+
+	if (decode) {
+		for (i = 0; i < decode_array_size; i++) {
+			decode[i].max_width = adev->virt.decode_max_dimension_pixels;
+			decode[i].max_pixels_per_frame = adev->virt.decode_max_frame_pixels;
+			if (decode[i].max_width > 0)
+				decode[i].max_height = decode[i].max_pixels_per_frame / decode[i].max_width;
+			else
+				decode[i].max_height = 0;
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 383d4bdc3fb5..8d4c20bb71c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -233,8 +233,17 @@ struct amdgpu_virt {
 	/* vf2pf message */
 	struct delayed_work vf2pf_work;
 	uint32_t vf2pf_update_interval_ms;
+
+	/* multimedia bandwidth config */
+	bool     is_mm_bw_enabled;
+	uint32_t decode_max_dimension_pixels;
+	uint32_t decode_max_frame_pixels;
+	uint32_t encode_max_dimension_pixels;
+	uint32_t encode_max_frame_pixels;
 };
 
+struct amdgpu_video_codec_info;
+
 #define amdgpu_sriov_enabled(adev) \
 ((adev)->virt.caps & AMDGPU_SRIOV_CAPS_ENABLE_IOV)
 
@@ -307,4 +316,8 @@ int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);  void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
 
 enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *adev);
+
+void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
+			struct amdgpu_video_codec_info *encode, uint32_t encode_array_size,
+			struct amdgpu_video_codec_info *decode, uint32_t decode_array_size);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index befd0b4b7bea..a434c71fde8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -56,6 +56,8 @@
 
 #define AMD_SRIOV_MSG_RESERVE_UCODE		24
 
+#define AMD_SRIOV_MSG_RESERVE_VCN_INST 4
+
 enum amd_sriov_ucode_engine_id {
 	AMD_SRIOV_UCODE_ID_VCE = 0,
 	AMD_SRIOV_UCODE_ID_UVD,
@@ -98,10 +100,10 @@ union amd_sriov_msg_feature_flags {
 
 union amd_sriov_reg_access_flags {
 	struct {
-		uint32_t vf_reg_psp_access_ih    : 1;
-		uint32_t vf_reg_rlc_access_mmhub : 1;
-		uint32_t vf_reg_rlc_access_gc    : 1;
-		uint32_t reserved            : 29;
+		uint32_t vf_reg_access_ih 	 : 1;
+		uint32_t vf_reg_access_mmhub : 1;
+		uint32_t vf_reg_access_gc 	 : 1;
+		uint32_t reserved	         : 29;
 	} flags;
 	uint32_t all;
 };
@@ -114,6 +116,37 @@ union amd_sriov_msg_os_info {
 	uint32_t      all;
 };
 
+struct amd_sriov_msg_uuid_info {
+	union {
+		struct {
+			uint32_t did	: 16;
+			uint32_t fcn	: 8;
+			uint32_t asic_7 : 8;
+		};
+		uint32_t time_low;
+	};
+
+	struct {
+		uint32_t time_mid  : 16;
+		uint32_t time_high : 12;
+		uint32_t version   : 4;
+	};
+
+	struct {
+		struct {
+			uint8_t clk_seq_hi : 6;
+			uint8_t variant    : 2;
+		};
+		union {
+			uint8_t clk_seq_low;
+			uint8_t asic_6;
+		};
+		uint16_t asic_4;
+	};
+
+	uint32_t asic_0;
+};
+
 struct amd_sriov_msg_pf2vf_info_header {
 	/* the total structure size in byte */
 	uint32_t size;
@@ -160,10 +193,19 @@ struct amd_sriov_msg_pf2vf_info {
 	/* identification in ROCm SMI */
 	uint64_t uuid;
 	uint32_t fcn_idx;
-	/* flags which indicate the register access method VF should use */
+	/* flags to indicate which register access method VF should use */
 	union amd_sriov_reg_access_flags reg_access_flags;
+	/* MM BW management */
+	struct {
+		uint32_t decode_max_dimension_pixels;
+		uint32_t decode_max_frame_pixels;
+		uint32_t encode_max_dimension_pixels;
+		uint32_t encode_max_frame_pixels;
+	} mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
+	/* UUID info */
+	struct amd_sriov_msg_uuid_info uuid_info;
 	/* reserved */
-	uint32_t reserved[256-27];
+	uint32_t reserved[256 - 47];
 };
 
 struct amd_sriov_msg_vf2pf_info_header { diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 75d1f9b939b2..9f74060207a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -218,11 +218,114 @@ static const struct amdgpu_video_codecs sc_video_codecs_decode =
 	.codec_array = sc_video_codecs_decode_array,  };
 
+/* SRIOV Sienna Cichlid, not const since data is controlled by host */ 
+static struct amdgpu_video_codec_info 
+sriov_sc_video_codecs_encode_array[] = {
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+};
+
+static struct amdgpu_video_codec_info 
+sriov_sc_video_codecs_decode_array[] = {
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 8192 * 4352,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 8192 * 4352,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 8192 * 4352,
+		.max_level = 0,
+	},
+};
+
+static struct amdgpu_video_codecs sriov_sc_video_codecs_encode = {
+	.codec_count = ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
+	.codec_array = sriov_sc_video_codecs_encode_array,
+};
+
+static struct amdgpu_video_codecs sriov_sc_video_codecs_decode = {
+	.codec_count = ARRAY_SIZE(sriov_sc_video_codecs_decode_array),
+	.codec_array = sriov_sc_video_codecs_decode_array,
+};
+
 static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				 const struct amdgpu_video_codecs **codecs)  {
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
+		if (amdgpu_sriov_vf(adev)) {
+			if (encode)
+				*codecs = &sriov_sc_video_codecs_encode;
+			else
+				*codecs = &sriov_sc_video_codecs_decode;
+		} else {
+			if (encode)
+				*codecs = &nv_video_codecs_encode;
+			else
+				*codecs = &sc_video_codecs_decode;
+		}
+		return 0;
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_VANGOGH:
@@ -1173,9 +1276,14 @@ static int nv_common_early_init(void *handle)  static int nv_common_late_init(void *handle)  {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t i;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		xgpu_nv_mailbox_get_irq(adev);
+		amdgpu_virt_update_sriov_video_codec(adev,
+				sriov_sc_video_codecs_encode_array, ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
+				sriov_sc_video_codecs_decode_array, ARRAY_SIZE(sriov_sc_video_codecs_decode_array));
+	}
 
 	return 0;
 }
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cmonk.liu%40amd.com%7C3aed0168a5d5494f634208d915cfbae0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637564804209668228%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Wyx7GoLCeZ5eTQORk5Loiqv%2FY2bhKYvpHIzAPXf%2BZOY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
