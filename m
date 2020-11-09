Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD55C388F9
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 02:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E1D206D8
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 02:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qndoZrXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E1D206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C718E892F8;
	Mon,  9 Nov 2020 02:26:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89861892F8
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 02:26:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fo+ARCk2y4LjMjo9j2+fHNRyxdpNUS+8iiOoVa589wQmV/LcTIXFF0IFX8tAsCZQOVsxCnzB8xTX0skKOYDcDq34i5FwWwoAxtNGA+D9bt7tmMYoNbwkW+MMcHFnBBbYgXCLNQLN9+CIVuU9w4MlSex8I7NPjC/2VfCDayrT9ScK3whcaSxMjrd8Z+JAKYNYPXNv2BQMbzZnDqS38r5uylkHf2jkf3Gwmu0NLS6k7OkMS6ra98jiuBFxddNFjr7+2T8nS8luvIuefJJWyEPxs1549gfjonE97OkWH2ndni9n4fEv26m7uhwFjHpXN24I8+cLvbpLgzaoFvL+46+ozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTSwltstTIKHqOiOMJgFyHP4z0CNryby5T4jTGV02yI=;
 b=FUfU7jiL6Ldlk1Lz/Qa6Eq7WI3LIylSd/VTRIjJli+WvPYpGX+VY15Z8XBPCA4YP/DqtGkbYRZ7HOHL9QM93Qoo6bbERzJzppUzHx4Fcn1w8ndEAiVWqJ73/fz2NbXIADzoyARhZVwD3pYAQ5XBShjdGMwr9LbMrH59/gW6w4i4JazKYs5RAV1gzPAt/rsKK3fdU1sA8ZmHU6rtU8pjpJtkotJrDw0OPwvBS+zzcOaAIcIhvuY5ATmTiFnFPpjn8U9SyR2Mn8kfMnpZuK1w4dwo3Lfh3WEuFcsnrO8c5Jzaez4zQCO1dmqwdZkGY+a573jjReqFec6JZuLxSacSXkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTSwltstTIKHqOiOMJgFyHP4z0CNryby5T4jTGV02yI=;
 b=qndoZrXxyC0rjHJ6xT5LuRRFO2+7yodrq0qbYCGwOnSZcMeak3490o2uY5+7iHwT5es92Y8cpTmTbMcUwVzHdawbH8KiSBgTz9Dthf3qJhwT1O0DaN/htKp7ziALtOJ2ZtADSpO5m6tGVirUbbE+/BdDT9g2CgtRI2dt9izdLvQ=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB2890.namprd12.prod.outlook.com (2603:10b6:5:15e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 02:26:45 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::61a5:a549:4cac:37e3]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::61a5:a549:4cac:37e3%7]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 02:26:45 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Add rev_id workaround logic for SRIOV
 setup
Thread-Topic: [PATCH] drm/amd/amdgpu: Add rev_id workaround logic for SRIOV
 setup
Thread-Index: AQHWrKzEluDDiaFyY0aFkB/m0Va8xam/Jhtg
Date: Mon, 9 Nov 2020 02:26:45 +0000
Message-ID: <DM5PR12MB17080C0F0FF6CFA3B6393F3084EA0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20201027220148.9543-1-Bokun.Zhang@amd.com>
In-Reply-To: <20201027220148.9543-1-Bokun.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8b7807bb-8c25-41da-bd77-0000c3a7c46a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-09T02:26:28Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ddd933d-4d11-4fae-aa25-08d88456e739
x-ms-traffictypediagnostic: DM6PR12MB2890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2890AADAF564B22A18ADD23A84EA0@DM6PR12MB2890.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VB0OrqbO6y95ZxwmkCdTh4bJsVTtZvS6Op2GmtPkXH/uWbAM9R0LcBMTlOmJjLE4yXSRwBXbWZpL9ouKCFdcSw970BHe+l/YwUzuugKf53frR3FQl3Ti99l/A4f5zeqzVYt2PbENONRf9ftBz6CADI36IK34UJkiTpJr8cW9+6FPZg4zLj20Gs18mqMA6JONLZkNmmCu2Dkhhd58ctaNjyvCmMPDNRTMEiSQY+pt4x6UoC/2REbKdKssfApWMU3uTA9XMlvVjrwYzYwshKuLpHcekj1gXo/6yH+JG2iWbL11PlaAK9klqa0ymHXKaOq9NUExg1mPW1nDcMBZc//1O6VXoBJ+VKe/jsUfhcgpMWg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(33656002)(71200400001)(83380400001)(6506007)(53546011)(26005)(186003)(7696005)(8936002)(8676002)(45080400002)(4326008)(478600001)(64756008)(66476007)(966005)(2906002)(86362001)(5660300002)(55016002)(9686003)(316002)(66946007)(110136005)(76116006)(66556008)(52536014)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: +mCXtQ/+B9gdPjtTUxwVf3ANLB4XJ2dOdoljgBxheFrtdYYz5v6S5yZLbjyL+fVKEkH36pYpKMNA4rIP9eI7T0R7u64Mma/7NVe0QulrmpVqdEeqdM+3GhNAkO8CEZ/2vg2K+9e8s0maPufPBRzFbEs99x/yg6t10LKZ4aB0otWr5f+Of8chziPjWh7vkrRssTklXTKe3ZUpTQ7y9dks8VAqiuHBaLOT120kRHY4im2akXkUlfj5d29L+oYyDgNaRx93a05wFeo7EVj/qfDjbMtwLqi8wrWUWOhwS/SFjBW5tnwWqj5T6I1YnjDCJ8pyffjEcoDA8L89t827JP0p5XVjvE114jDjosJ5DBeiRQYj0ffu4wC8i5CJ/PwfEqa/uLho5461kBISb/JPyQIwmpze1xPN8SM/OuC7CqHxEHXJ1yW6ojTXyt+EyW/W2ReE8VGcPhmq+mAZVCe/ihoUcSZKA4IMRMXzU8VK7LDNoMsTr3oOTjO3sbwdf5HNeBLjuJ6YPGuh3FyOC5eI7+BK5rjCZQyQ/u5bgBAdjG0d0ccibnzvZNyvm1iSbtu+hFZBTfzHvdnXfHA7MIFKMSSRgVy+eaT+dl0qmj9CP2v2sC56to0njNqg9AoDKdxr8NQg7SjfjlYhyGIoMT6STF308g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ddd933d-4d11-4fae-aa25-08d88456e739
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 02:26:45.2945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/YxD+6Rc1qLVv+8pCcLZnQqlzuc5MiSUcVdcaGPriZIe2T9+9EB5s2GFsNiAZhw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2890
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

Reviewed-by: Monk Liu <monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bokun Zhang
Sent: Wednesday, October 28, 2020 6:02 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add rev_id workaround logic for SRIOV setup

- When we are under SRIOV setup, the rev_id cannot be read
  properly. Therefore, we will return default value for it

Change-Id: I188d8e1b77f97c2eb29ef01aaf9ff9ea396a51c2
Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index e0048806afaa..04c152843601 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -53,8 +53,20 @@ static void nbio_v2_3_remap_hdp_registers(struct amdgpu_device *adev)

 static u32 nbio_v2_3_get_rev_id(struct amdgpu_device *adev)  {
-u32 tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
+u32 tmp;
+
+if (amdgpu_sriov_vf(adev)) {
+/* workaround on rev_id for sriov
+* guest vm gets 0xffffffff when reading RCC_DEV0_EPF0_STRAP0,
+* as a consequence, the rev_id and external_rev_id are wrong.
+*
+* workaround it by hardcoding the rev_id to 0,
+* (which is the default value)
+*/
+return 0;
+}

+tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
 tmp &= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 tmp >>= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cmonk.liu%40amd.com%7C5ddf2de922c74ecf2b7008d87ac53dd3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637394334870430374%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=vPCdjXdjfuBEPAi1gcgF%2B8oGDQCQeZdSLzChC8k0DWU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
