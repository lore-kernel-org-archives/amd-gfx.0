Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DC3C07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 07:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30ACA6128D
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 07:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30ACA6128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B146E575;
	Thu, 15 Jul 2021 07:16:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC606E575
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 07:16:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gp2vqAwcQXjbPtcdXDv4e6TCXeSWfb6wqmBVf4xLLgVZazwMgpzMCJUwivqksy9Qxr8XTbNpIlFgQkiUNe9lg9CHeIy0uqtNJRsoFQDiDKJFIFlg0gknuzogOq59nDpkwzsRrQPgh1N1TIxPBxt9f/N/23fGzZAZV8Q+1c95b/nv4YwdcZMFlRyJCyfJQLYMowepBdE8vb9zr9h0jwGglEp7yS0yIK59EZdf7Dle7vsghqZSIL6yeFfTmHXaDejv4obBTVzp6g3FXIYcUcJfjIUOJqTlfJtsEQFHrKiNaq3uhnmo3I/qzCPKBAi1tCtIL7aid8ZcAMdLPuXR+X0qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ6Qe3275a3NfMg4DIpDTiEs8D5EmL3htIvIEqwnj9Y=;
 b=ZfJlhx5cS6eoFjUA2ttO5IYl94UxmTWCvVe4eEBuWmEutFA7TJu07F0nPgT7OOKGKBICERjKM4bC8ettGl5y2aV4NcbVEHjet1ERQBtBIg6l4pBJZdPJ9nY2WLvNT6yJlqRfe72lSQTdEmn5Te5vJehxzK2jJXqAO+1+wY7HYQ0BBq6WP/C/Gpb1ZnHK7e/rPNgqNFaOO9x7Urxhq9C6wO0A03N525IfbOU/JRKRbmTgJidqzeuH9nMnqnvdhLyBKG1YJqngWDxLmSg3EIZ9UxDebzxNLMOQyooQFk3gmZ6bbdW4B7PcwaUFI5EhuYCenc+N9M1PF4eG5YrXVVNi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ6Qe3275a3NfMg4DIpDTiEs8D5EmL3htIvIEqwnj9Y=;
 b=F484rkR9x39iu1M8Tc05+Vg5uR9Cj+b6W1AKXjijkEWZXjkXjFMlSPGtDLQlX+/LFZ9U9oCed7arkp4ZFA8m6L8gE8sk1Z4IS0qoFmb7M+j+nfFCTKhlSppsV0gntAcAwEf3gWcVRnJ9+PgLINkxwUGZmzAnrGinSMTSvtdSR0w=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB4679.namprd12.prod.outlook.com (2603:10b6:4:a2::37) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.23; Thu, 15 Jul 2021 07:16:52 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4331.022; Thu, 15 Jul 2021
 07:16:52 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Jiansong (Simon)"
 <Jiansong.Chen@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update gc golden setting for dimgrey_cavefish
Thread-Topic: [PATCH] drm/amdgpu: update gc golden setting for dimgrey_cavefish
Thread-Index: AQHXeUjXbahyA73h9EyK4GhRIDFCMKtDoBbw
Date: Thu, 15 Jul 2021 07:16:52 +0000
Message-ID: <DM5PR12MB2469134659CC118165851C73F1129@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210715071237.32320-1-tao.zhou1@amd.com>
In-Reply-To: <20210715071237.32320-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-15T07:16:50Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4886d39d-dc29-48fc-8650-b7202ad5c190;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcdd7e36-b423-4b57-ae2e-08d947608547
x-ms-traffictypediagnostic: DM5PR12MB4679:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB4679978A19697E83E654E5F1F1129@DM5PR12MB4679.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jvah0qVjFP+71Bcrk6ZZ/P7IoUCZCpm1okL5/cUldqLLbhM9e6S9D4ZuHK2vfZlKs91J9yWdZvUXCPG+ru4TyytCZy6gLwmixxAxITwJHkiL7U8nlAzlnot5sH+BGAHvv5WXiCwbmIalkR65DwjXayV9NqKHcLPwG/lZrtH+l0cjA9XYjIKeM100om2jRayRQBi5SI3IQGwwPTK32HOsgwTuiXroe3sgm6JZ+ykSEbR3uAeNVG1wQ6eY5ggfbgRcfCOfyVw6a67zvm00W8VGCVqtk0WxNrHcjQiRs9d+lXSMeZ0QvdXevE5HwdMr4zHQHSiIKq3NUWMZ1irHkKEpltIlCgAnTZQ+bIK+F2JWMKIJmDe46NU/43Z0EhNE900ysE1BMXBa+gddyYNmxadXsg6kw7FNLadAJRUb3aG1/VkiQkBHXZncPtudAFeZF3tBNUFSrqfqxDJ6UKpo1MzKKfQSbw1mlSdpkVdwoNttUmyyiTSfxM6rZ5EsFO8ohVax+c+r94OoIWY7IeIiWXWEeff+V+o25RW3Asg/UfPpBdT/GvmJtQD3tZVE9XVjlia0av/n+QPYslk+9SvaucgRDCpWPXO8N4eRUJ7xFG0Sb9wm6uWaBMpLPfoYfBYms6UJCWuB6nY2q/P4uIrKHlyBc7IN90cQoFiP5Z6HxEVBQtNlHWnDKPMkx8oMFgws3hkG1yIw3m3zCiztK+fZ7S1dhg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(110136005)(4326008)(186003)(316002)(26005)(55016002)(15650500001)(8936002)(71200400001)(66476007)(66556008)(7696005)(64756008)(66446008)(66946007)(122000001)(8676002)(38100700002)(76116006)(86362001)(53546011)(6506007)(5660300002)(52536014)(33656002)(83380400001)(6636002)(45080400002)(2906002)(966005)(9686003)(478600001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3GXwNkW30PI4RB++iXuDoSsMFk+S1gC2n+IcdjXBMMrnmHh2WGy5YQbyno7E?=
 =?us-ascii?Q?fFtplO7EpiP10Dznwzoneh+JF6f57+vX2xl20dOb2bq+wZvlFM2mGL22Mpr2?=
 =?us-ascii?Q?QR4o0wrBW6DmZLbxrsG3FBDcQKNKL5idStQMPzLKOCdpkkcKzUHVybZkBe/q?=
 =?us-ascii?Q?LIS6FtcdkRAkV0lwKJOHdTKhDrt1BnjUZrrDN6aJgrMd5quiUCZkfVKNTlHT?=
 =?us-ascii?Q?dA3VjhA5RCFp0yOSveRhZk/TOq4g+t4SQAFc40bHjg2KYUG66gOyvhzYG30f?=
 =?us-ascii?Q?t/icTXKiCmvqeeNS3vFAfurq1Xz4p3PsoaPyw4teHL+mzh9dLZaHllZwjSYa?=
 =?us-ascii?Q?3mBRNYhLdUhdFbsgESxublRWzVa0hBqmVR5jcCBPR7F42efvTNb9QE9s1Rsg?=
 =?us-ascii?Q?SDY16jndjbn+ph6/E4XNolDRCx6cXHil8v42FMxxuUvo7YT1sW09jX96LeH1?=
 =?us-ascii?Q?MLuv4/FhiXQmr3a4pBAluVt1909RmJgcPlBsR9vkNRQQPcLpML6r6AlH57wd?=
 =?us-ascii?Q?/OBWXamOOlO5eEuUc1fHYW9BZLSV9EwWsnKhONs5/ZoM+9/v6mzg5y3kU+ww?=
 =?us-ascii?Q?o7wMPTYCMmYcUnPNUGwhoRXOIFEx4MFJ9akm263UyNsEQDoN+QJzHpT5VhUN?=
 =?us-ascii?Q?N+E+ILG/vGjCfLwOMebOU98UsgDS2Z7IuZDrFUG0XDk9eBZOI1XPAsIAVg70?=
 =?us-ascii?Q?W1tCXsSGzXyUeLmLP8khpp5gvK9TY7O/wyPMLznNQUayntXBpcVvWhZIahJ7?=
 =?us-ascii?Q?Wt60fxGuBHcKbP/v21fzQtyMdCOu4xOd1Xb0OEDMsbt4/+44CSwa++YK6GhG?=
 =?us-ascii?Q?gv+5teyrMdTZOvZ+ntMv05TaDM3F4v8eE9HqTx4lCBQYpmN4CLRvCPPKc7Yn?=
 =?us-ascii?Q?2NWUhrjSq7EKEYcoXL7efqLyNCMYJfGcvJMvJo+4zVBtCbOo/LFCqyjYO7gI?=
 =?us-ascii?Q?kSoVxZdINyGaqwPbniIWZ6p/AdkIiyrbbQvijFwU925s+FuWDXT1ehSeTsiJ?=
 =?us-ascii?Q?Sl1WZvh7V8TtNEcbhs/7j7As9Yq5tiS8vjbVdPlQoVTF8IOy31Iv/11/TJtu?=
 =?us-ascii?Q?lW+QYtrmXyS4hWURZViL0a1/ezHDUmXdzM+rDlZ+6m0PGTt4zTTxMrDcmHNa?=
 =?us-ascii?Q?ZaRTWUJXU1OU63xkkJr0EDvKN9JFyjdjK0+P3ZmQZep6jNB0HwvjvYIZzdlV?=
 =?us-ascii?Q?tx67l3GMpPeoiZ5hOn0LECWQpURhOHOtf27VMHDY/4C7sQ7R0bdZwhGh9zK8?=
 =?us-ascii?Q?F7KI3xEkm8RrAvMFcoo/A/2aFw/LRlg/QQkh70GVweqrDey9MgX0HGLfaeSI?=
 =?us-ascii?Q?8xordSLv/PTxygChD+WvBz5g?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdd7e36-b423-4b57-ae2e-08d947608547
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 07:16:52.7775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fBw4qNMS2OFGxTShcCX0S2Ribgf3SNWG7WLplXlDB9Grv+0wu2LHCOjxOpoUJ+g+Eb8DwukREwAGtw7g9i9wxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4679
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Thursday, July 15, 2021 3:13 PM
To: amd-gfx@lists.freedesktop.org; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: update gc golden setting for dimgrey_cavefish

Update gc_10_3_4 golden setting.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 80e7069e12ac..454293ea5b02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3451,6 +3451,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_4[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER7_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER8_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0x00010000, 0x00010020),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0x01030000, 0x01030000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x03a00000, 0x00a00000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x00000020)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Cbbc1f93c97fd44b0a98c08d9475ff841%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637619299789839486%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2BPBT8LY0rXAwkolD%2BT0YFn0mVzlXRwvS1gXI9gvNTh4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
