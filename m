Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E700C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 22:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8F620674
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 22:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WuvnSO+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8F620674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C0636E3A4;
	Tue, 19 May 2020 22:59:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D76A6E3A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 22:59:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oh6s00VaKwZdwnAzG44AjC69exhrvZuBcGyVYfTlc5UUwHdx+TBsneXGfL1M+JJGGA4E+YpHdVAB10R60zbQJpyxBB8U1+pHGDs5QCUoRMnyyFCnLCq8TQ1XbX9jaZW1P7N/ssoC7AItnMwKCM6vDh+eKRp87M1NPriu9/fOzMTlBlh6ooaRAbh+j9Jb13RhZA1N9//bDbNmER+DtxDAN1+ia/RPnZtKCQatoRC1s5LQynhit5wPW9UnDIazptIWtbfTU4d3S+F2kqWHmotXN18yhQBkg141/6nVgYudKAY7Pm6Hpoe74Vg/IXeVZgahXWggD88l3aVEGx7g+5tApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPG5QnoEGJjzDPJI0AKW7lHU2Ehspbiee0Fude29vVU=;
 b=h3aiihmdblCwrRTQ5YQAxh1khv92Ojz+KXV/PCZnrmrkTiSxW30Eaba9SOzJnqzZf/1Raoqa5Krj035TY73iFutMzy71my+pbxtoqR4wCHXlWtHcxGU189i9RuDA3maS3g/VRlkaeJ5FDsAT/xUXPhbao7Ayg1adujoYwG0ig2uwqo7S3l+Nq//Q5aNmuDfTG7NAj7XN7R16YNekdPSMqfHgH67RYr5HfIa2VubccaefuTpsSlJLGcDobotvJ4UgDI0+8JQEAz6+LTtdGWd9NSNHjWqrXL8QEQc4zbT7oBslgj6HCYRaUQ/A98NECyli4cjRoe9WvauBdL8WBm17PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPG5QnoEGJjzDPJI0AKW7lHU2Ehspbiee0Fude29vVU=;
 b=WuvnSO+Yhh7IpCP0RQrPBpJY9qXQE6wJ5klTH6+ukqBTrNnxShQsE2Ioziz8I3chKbjRI0x/IPV9hLBzezBSeCkI3fqNn9ZAOAgLY/eOfHtJI+yJqXUksX2aZBgq8YRAV/Kf8JeioZi3alMsUHUg9nHcwFU741o00UUIgq58Fnc=
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM5PR12MB2566.namprd12.prod.outlook.com (2603:10b6:4:b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 22:59:13 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::c49e:273b:1455:22df]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::c49e:273b:1455:22df%9]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 22:59:13 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/vcn2.5: Remove old DPG workaround
Thread-Topic: [PATCH 2/2] drm/amdgpu/vcn2.5: Remove old DPG workaround
Thread-Index: AQHWLevJU4tFZK4hK0GjWVkKBnHze6iwBimQ
Date: Tue, 19 May 2020 22:59:13 +0000
Message-ID: <DM5PR12MB17877A0D41F8C1D82255E65BE5B90@DM5PR12MB1787.namprd12.prod.outlook.com>
References: <1589899297-19138-1-git-send-email-James.Zhu@amd.com>
 <1589899297-19138-2-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1589899297-19138-2-git-send-email-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:a200:445:69ed:631:dc12:c49d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 22e617b1-1b9c-4642-38d5-08d7fc483fcc
x-ms-traffictypediagnostic: DM5PR12MB2566:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB256657C4BF532BD25E3097ADE5B90@DM5PR12MB2566.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:260;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qyz3zAYDqZItCihwJSuzdgzm4SA6G1Y/bIcFiZVrVuyh+XafrFTNnt313O3XTNynr0Vg1xUL8LPnCtg4dgUeKu0AXeUg7UfbZRNNEmoEcaLlk6xMcgGopEj66Qcni+skD4ia1acPC0fsWAVpiqZELZi9NTZRgJdNZlfy/+DIKQHoWVBSioWxbJ4ixn/Aa+VYRgp4UyJn4TcaPYh6rn3Kz8KpWYuS1F58a01T/O9knVBBH0cLDjRk15N9nM9pd7+KUTz+A/YdND9ncz8kGnuIyLsX3QK7e5jmg1mHQEkEC0nkFVSRlNGG8n/68BiK2nOYF7ofyj7Ll1sEgiqL0TKlFbO4wRAOz9m5DUIKMS3SlMonh8WcnTZSab6UsXhGU4o+Zvt6m1LsEL0nm0fwm68JZcAo4KjBfKfmxzrCp9ZYyn6ppJ4uBzXq3jHl44mk9mNQjDCdhnBUBjJrXjEjR5S1TwnUkQVTEbg6QqbUR2Ryb5c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39840400004)(376002)(396003)(136003)(366004)(5660300002)(71200400001)(186003)(7696005)(8936002)(2906002)(33656002)(76116006)(66556008)(55016002)(66476007)(66946007)(86362001)(316002)(66446008)(966005)(110136005)(52536014)(6506007)(4326008)(45080400002)(8676002)(478600001)(53546011)(64756008)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1fSuuRaucLEtYk0jj0XhWRukoB+jnJsmAXUhn2Cxfr+ergnxaZFn7Yo2e57ezhaNKl8/qrR5cNCn2DvDKfWsX5+kzmsaR0QdQtIX5CkyE1y+NO29m/+tYSdx55SNDMnfX9wyuOdVxyAyjxwsQeL0nBTROA6O1kFGv+PddWkwwdcC0TmrKvqQPdp2xV26y6LnJd0D4P0idPh0JOHZ5zcBz9rU5SG3UwXWXpiHx2yoxw9oVSL1tMgOnhgOymwJuGG75FNswjTyb6xXdcg6rVlaXDjd6CROyYRW2NypWvPevckJtb216WvpvoiQH9TEXYwJjoGo4nNsKBpB+A7mdhY64+L1RBNUbleaiUhciXZIWtG9t+vyPQ6fTNbMzW9q9sQLPwN3sKHoR3Y13huaiwGAdo4QoOi2FaEAKLxKX8F+HsRLj+/ZwmPI3ROHwAdM3/sm+h9XoDYABnN93SZaeXm6zxT972NH/Em+VjaWKlAx52PJCSwYF3XOyAC+5Tbg/03qBbUPikinVFAVnxxEbY/yQM41D1WwzblWvPsX87z1k57+cn4qQ/C+oox9Zy0hWWOV
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e617b1-1b9c-4642-38d5-08d7fc483fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 22:59:13.2858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +GBVFf9XXRFxiqriWawexlBcf+PTFsojJGz7wY6TvNrKCTDy9RaPGvBD7wMx7BBP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2566
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
Cc: "Zhu, James" <James.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The 2 patches are:

Reviewed-by: Leo Liu <leo.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of James Zhu
Sent: May 19, 2020 10:42 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhu, James <James.Zhu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vcn2.5: Remove old DPG workaround

SCRATCH2 is used to keep decode wptr as a workaround which fix a hardware DPG decode wptr update bug for
vcn2.5 beforehand.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 34ed906..3c6eafb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1453,11 +1453,6 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
 				fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 
-				fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
-				WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR,
-					   RREG32_SOC15(VCN, inst_idx, mmUVD_SCRATCH2) & 0x7FFFFFFF);
-				fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
-
 				/* Unstall DPG */
 				WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 					   0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
@@ -1519,10 +1514,6 @@ static void vcn_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)  {
 	struct amdgpu_device *adev = ring->adev;
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		WREG32_SOC15(VCN, ring->me, mmUVD_SCRATCH2,
-			lower_32_bits(ring->wptr) | 0x80000000);
-
 	if (ring->use_doorbell) {
 		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cleo.liu%40amd.com%7C285abea632d14d797dc808d7fc02c54d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637254961773506391&amp;sdata=isg1c3TJ392Qeos%2ByhO4zopT3Y%2BWA4G9VGKBd1pLT8M%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
