Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4924C5518A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 03:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CF02074F
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 03:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RcD3N4hN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CF02074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFAB56E428;
	Fri, 24 Apr 2020 03:45:32 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C42BC6E428
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 03:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhrutZMTJJrwnZKd8CSaKq0daJuZJUGrsOFYFOQA5DBOB2DdqACQ967wRkHt6PhNsCJaCLkM7fYfehMd7ReiIXcM2fkfYj9Jee2p7L0vzGqDBJ2ZETeYLwTHmTR0pKCBOyAdb4mG8QhxoynOTxjVjyiS5mvY+V+LEhwYBOrxxM1l8AxpeL6ussv/WyLiB3h9nsMMJs41Qvn7YNTp1N4K43pU4Uj3jZmiaRoHL9QKNcisuT86W+QIPTS4BbcfpqVmaGqezrsHTL5X0ueTXXv9+EvAd619RXe8FIDoZ8SkiFsZcqXD4mUJQyKAzUT7Zhz5pcbBunFjZtUNqJ8wo7W6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URfEJwq466G25/V8OItN3CcnDDSdHDo5XY3zDTZfA5s=;
 b=iS9aTrMF/YrOS4DzQFTaKJHOoD2sojNY0HUFWt5OL3bB0zBWB8l2sOUfN9E2YCoorPXklFNaseK6ToNgWq5A426R52un2imQlJIaSTK9m1PSEsnIGoFxYddp9C5KB1+dL6zbIYkdnptEplk95AzyDGx+svl6VbKXW4LalgP2qEh27vg4YTftsiRrL0AO9FbWu97QJ0G2RGAK+YXrWEf9CH2d5CoFYEutqthe/xqbDt6e+8B1yQNb8rumdplLjT86OeIwdewqTstIa7TPqeG3YS6W6epxNJKzZHYgE3BIy1zwVlc86vOVpSx/bAmLO8q1sKL8dSy3dXJbvcgRKkOhdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URfEJwq466G25/V8OItN3CcnDDSdHDo5XY3zDTZfA5s=;
 b=RcD3N4hNPdIW+PyissD23MSgnXHCAsl7Fm/hzwUQpnyuQfASlRkRSglAIAkJCx496jaQ/X2gDZ3s3YwxyDiKJgBh21LbfX3QmFCKd6wKuzfE2RHeyU5fqWEozW0q30jJ/fIECPr0C2POGPgDfN3KqhwNoeJyQy7cFEVR8PtPctA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2635.namprd12.prod.outlook.com (2603:10b6:5:45::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Fri, 24 Apr 2020 03:45:30 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.030; Fri, 24 Apr 2020
 03:45:30 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 8/8] drm/amdgpu: for nv12 always need smu ip
Thread-Topic: [PATCH 8/8] drm/amdgpu: for nv12 always need smu ip
Thread-Index: AQHWGT0+kDgqYzEUcECpkUjrUeja3KiHoiWA
Date: Fri, 24 Apr 2020 03:45:30 +0000
Message-ID: <DM6PR12MB26197576FDCE17DCD43FE818E4D00@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
 <1587625306-20704-8-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1587625306-20704-8-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ad8a0903-0ace-4b14-b00d-0000687cd1ed;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-24T03:42:01Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a2fe6a0-35d4-4ea3-3d4a-08d7e801ef4a
x-ms-traffictypediagnostic: DM6PR12MB2635:|DM6PR12MB2635:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB26358D2BA0DD41B3EA881BFEE4D00@DM6PR12MB2635.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(66556008)(26005)(66476007)(66946007)(81156014)(7696005)(4326008)(76116006)(6506007)(2906002)(8936002)(8676002)(186003)(86362001)(71200400001)(53546011)(55016002)(9686003)(110136005)(52536014)(66446008)(64756008)(478600001)(33656002)(45080400002)(966005)(316002)(5660300002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bEziGJqikZeAuta+EdaIee9PajLuvHB9yMHnjPFFq7QU70AiG8bpL2WzCbr4mbd8N+lSMJEdliWGydIFnN+95z7y6fpHDZVp7+SGGbi9hec85miCfATLhSww2MIOE8WTNbgYMn1qWzC0z6VsHNzBY51GcqGTdFfiVfRtPu18abgm9/9kjdctLlPxOR5BB3isF2777zUHlW8pQnAuYl1nWrFnJKQWCzgF2eI6/vqoa+J14qE5kdfgH2WaM6Xf7sDpD4tp+H9s3IORQJl+HgHPmXhFyMhvkvocIPiw8N+mD6VsTB8ApwHOf+A0JoxsjpEKbSmUycs9B/wynkqoJycOeU04T9m4wgKpSFJTWOnFztX/2kQwC3lq2Y6JZCKVqRjXrE7deNp4JTWblHNCnSeZfFzByz1+ea+YaoAJbp+/B7kGQkkx9qaDoFOdIQIGa23MGz3OzBR1dRpY5cDYodd0FwlBQ6YQAhoLIU3P/pXrkD4=
x-ms-exchange-antispam-messagedata: jq6074FR5rDQTdN5d8bCFGc3mMRzCYe6QwSg0KhP+lB5XzE2U2DHtrW/tX/94CmFUz6VDO5dWP3ADRnx5yqx0DJCqXm1EPzFg+YDIUp7BpFWX5po1T8azufPmuDUqNJinr9fbaKu9uZpIvXu8ZPOYw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2fe6a0-35d4-4ea3-3d4a-08d7e801ef4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 03:45:30.2606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dH3mPTk7UDuNC8T6oi6DvuioHvc123OxKO9Z09zMxuA3bxLC+CVmEt57VGYZiOjx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2635
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please check whether this is needed also for the following code:
                if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
                    !amdgpu_sriov_vf(adev))
                        amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);

Other than that, this one and patch1-4 are acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Monk Liu
Sent: Thursday, April 23, 2020 3:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>
Subject: [PATCH 8/8] drm/amdgpu: for nv12 always need smu ip

because nv12 SRIOV support one vf mode

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 995bdec..9c42316 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -498,8 +498,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
-		    !amdgpu_sriov_vf(adev))
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C0776cfa8343f4992679608d7e7543a7e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637232221889995485&amp;sdata=L4BeRmyYxVu4to1tk%2BtQANvWg3fxTtjyv0zroWUJ3jA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
