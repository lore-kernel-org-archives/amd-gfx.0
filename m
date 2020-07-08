Return-Path: <SRS0=Rlnb=AT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D57C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 05:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C5A20774
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 05:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JvK7jVIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C5A20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5B16E858;
	Wed,  8 Jul 2020 05:30:04 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770055.outbound.protection.outlook.com [40.107.77.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A314A6E858
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2020 05:30:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFptT5yWh2IM6AiHq36M74x/Qh1BIIZDNz18Jab9gAPhuqwMjxsafRnDdCLtvJsRME9aLGJX7ElKjTxstA8QkRSeJtRKymTO/cuYxI4OJYYRKzB/itSp0K3eleTso9z9OmADuVmUFDSeDS5zYHTxj8zylo169oIcl7ZPlvwhM7AklrxsQ54UKzk63NWAfEiysCD5igiZrYWW3Ml4togFz0NgHGhfP508XX/VqYYadTkp9+6GWSO82eQ45obl6+sL7ibe/VX32pDPX9cOkNr2ABySiWf3JdcJYkfSHUqXqHGHAv1oZRMB06va0rT7swnZ9Z5gkel+GWZyxvHL3nEL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdSNOJNZqkwgD+TZ4emJV1olqtrhI4gQbR5Fg7okMGE=;
 b=chMFRc+LApnCIZ6Z8rPnyH9I3ifzYU9MTK/4wNpXZQKbykbnoXoqKDMjrlv2k5iVUf7N1VrhSfc6CJxnP0AJzJhfle6kmHgPcNviMcdoFO+K/VmEG3qd0BxyGx6WrYrOPekEOAJCUuhAHjVrwhGVFpo6Y4LSLUnLe49T4glLCkYdWup6y0s9pzyuolFNRxKmX62AbdKA2CiAF8qLrKf1JyjRXEAM5kT8+qhgeMR64cnBzcq01VVe+oHLEgOIe0SUL4/5qNAbRK9my8KTNJDjsXn7p0+uysZNNruMW6J01zBxG4xyrT2gQEN5GiTaqvtaH8HTQN9zXYv3Fiu6l9q/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdSNOJNZqkwgD+TZ4emJV1olqtrhI4gQbR5Fg7okMGE=;
 b=JvK7jVIorkdtvLyFBlW/Rfog8p8NAMndwlVCJitzR0gpiq9vtVLEwKpgcLQBx+4GQdsPxL5WoGu38clHmHX6PuNGWQi0zM3VzWbM22OpM/Dhs15eJf06cSKtFQDEnAy09NdfqdHt5DstqY0oEZpqoP8WeQeXRgfF6pFY5dXcinE=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Wed, 8 Jul 2020 05:30:01 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%6]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 05:30:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable gpu recovery for sienna cichlid
Thread-Topic: [PATCH] drm/amdgpu: enable gpu recovery for sienna cichlid
Thread-Index: AQHWVOgj/xAvviTS/ESHuq5gTsmzdKj9J7oA
Date: Wed, 8 Jul 2020 05:30:01 +0000
Message-ID: <DM6PR12MB4075CF3F57CE35BD7A17642FFC670@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200708052442.3007409-1-likun.gao@amd.com>
In-Reply-To: <20200708052442.3007409-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-08T05:29:58Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=81cc1b93-1f31-4f57-a587-000054f67ff5;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-08T05:29:54Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 15de7af6-b4a0-4bf3-a16c-000058034b09
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-08T05:29:59Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c8eb2080-1591-4129-9b4a-0000f8313caf
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84b8969a-b037-48c3-fe79-08d822fff630
x-ms-traffictypediagnostic: DM6PR12MB4516:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4516798E7D133C5EE396E01AFC670@DM6PR12MB4516.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rQ1y1AC27hpKoJWB1YZCfRs81msjJnfteZAjoMijxTW8UCEU6PyoMh+YqGpT/Cq2BLBSrhyAM+k3XdTGgjpmqUU09o7jqbW/JiQpuERmNDa5Gf/fKKWagBur+nDvcFtS6z7XbAkWI7GQqRMD7V5Vx/VqJvLIqk5dTo8X3fthjwXJfcE+wjKZGV9F0dCgh+T3YjJUdItaSjjXLX5Iqqrw+5fPxpKYvsh4Uml1bUFLt605nMbkSUopMEjoub6/xvHWehBP4eMTDHhiiQ83q7jFBqzMXBM/PASqOOFwESqJVnxZ7r6fSZmDSsk1DhQ+Ex6jJcrFk7IcLY+SGZRoM+Wriw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(7696005)(8676002)(316002)(52536014)(55016002)(9686003)(8936002)(26005)(110136005)(71200400001)(186003)(53546011)(64756008)(66446008)(478600001)(5660300002)(66556008)(83380400001)(76116006)(86362001)(66476007)(66946007)(2906002)(4744005)(33656002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: F2x8M5w3YqtznY5KDGlLiXjJXX8nPv2pTOGh+WpqCLXCA2MqRbgfRvBuK+NVTxzYA54TWkUOVeeAFFBRsknIx2nSBwIoOKVs/JJmJ+4psQOe+w0Pxklc2frf1qFdX+RIqsPlSYxPHdunW3w+M0eKSe/C8s7x+uuJNh4N+Q2OqXQ3BPedqapxTET1rklqDjk/hm9ahFmbg/ZSRDoZk9WhHiFKdunlj0H6UfUllL5zxCK44xXyV6/rd6hNEz1eUrz+gF30SLj5TzNsEVEhC5+NuPy/HCAkApgWvWjzd3kGbHAVrspGsSevnDXIb5OslYsC3AUk6n/vhRbfGibKNb/kdzGIJIk11djr96Syhx6Sn8rISjS8LnCdUxxtbBSOhI1AAeT1epCl2gQGW0+X/bB6sZ2+w8i+r3tz3MPsJN1z+fTXNUWW4eAvEXqLI9wPTAX/9jPblFPiFAU/vFYB8HWbyOtVJ+i97iKD1snxHOFx6WhWSnDsU6LLCnA5dDsS4tOo
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b8969a-b037-48c3-fe79-08d822fff630
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 05:30:01.3454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3RtCBaT6am954ifuT2MJL7UV+tFbxGuaDLcxN+FeTr/QZQXid3F0iBBEyB5CGXCmT4UGbgwHbO3JtwXMbnLlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Wednesday, July 8, 2020 13:25
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: enable gpu recovery for sienna cichlid

From: Likun Gao <Likun.Gao@amd.com>

Enable gpu recovery for sienna cichlid by default to trigger gpu recovery once needed.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Iaf3cfa145bdc8407771d5a26dabb413570980a85
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7a610850a646..2913e41f63a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3936,6 +3936,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 		case CHIP_NAVI10:
 		case CHIP_NAVI14:
 		case CHIP_NAVI12:
+		case CHIP_SIENNA_CICHLID:
 			break;
 		default:
 			goto disabled;
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
