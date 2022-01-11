Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6ADC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 03:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2481610F8AC;
	Tue, 11 Jan 2022 03:00:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B0C010F8A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 03:00:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/hbHoDOtCF0LGVaH3CBu3rm5W7+1Hc730DPKcAmdnX94EwA2GK8ChsrwIw/j3samPwxMNJS6Qr6FKXnNX6LVwRGKo3kJGzFQuiP3FD4ZGjF3nOKmjE4BB7yX4NLorFsoNiEbx7wzBZy9omGLUjVfdH+k7mk/FeHZUsZVzr5ZpV+NdhDeuYanPtgiw2rca5/+FcjzqaFhZaN1ZU1PKnR1BdSFMLTeUSdq8t8xbDtBfW8GXutPry6+cy2R3Uyl3kVAG+aN7ddlfjCBEWcTu+qWjaUulhxfNjzbKHZZqy4jsUSnJ/UVum7Jo15WG941MINyFO6RDvGcd19+W8NiXjJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMcpBHiVDn+GzQYseGrZ9Fw0MTFCBnfDv8cfg1hvGng=;
 b=WXRDh9vqcyO58Eg8O5s1Qs6XrBfDlWAeq/J9mZ1cRbVHyoSVV57NUnd0fvfaCSsHay4SXnGYPmm6HRBYYlhVBV4S9ocr3k2UfEC2xYJgYIGZVOcngIRXJ7AaSBqS3GhEJayaqHGk4660TKZF1ITn6jfGL4/Jw1yy690Q5064Of+tXL1Q2bp4qr7qQsZyV0/8V5Y9w8RLwZLtyu563AMooO3NKGIYJxlkNRg5VquCur3TviRTXzDYKRfdFi4u7OvOSeJCPrEr7Le8bIQ9qWOcd+arN/iG6H1Crom0QjGOARgQVHmC86kpHcjHDDxP/ze5MKtzcEYCLLXfMcqPy7jlDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMcpBHiVDn+GzQYseGrZ9Fw0MTFCBnfDv8cfg1hvGng=;
 b=WPcrovGqDfqzHe9MNFSHVNba0AQN6LHpxzuQ3SSpKHDqNKw+Sq8QHDt/cr4VB7MHx9jGvjL5MBqeHt2LzrvUGZuuc5R2rPo1OeHXh0zjKIimGDOP7JSzdvP3pCxDxEo9EPd7/6CV3CGkxi1diL4j+/HyAwY9u7aqqgprA1zCBno=
Received: from BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 by BL0PR12MB2531.namprd12.prod.outlook.com (2603:10b6:207:3f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 03:00:49 +0000
Received: from BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::65bf:c277:8d56:e18e]) by BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::65bf:c277:8d56:e18e%7]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 03:00:49 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Huang, Qiliang (Warden)"
 <Qiliang.Huang@amd.com>, "Zhang, Bokun" <Bokun.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by
 local interrupt
Thread-Topic: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by
 local interrupt
Thread-Index: AQHYBeDh7HCEEMC4R06tynQJINaERaxcZWWAgAC8vAA=
Date: Tue, 11 Jan 2022 03:00:48 +0000
Message-ID: <BL0PR12MB2465BDB9A4785355D6B2738EF1519@BL0PR12MB2465.namprd12.prod.outlook.com>
References: <20220110051344.29134-1-guchun.chen@amd.com>
 <BN6PR12MB117124D8D3DAE8FA8B75464BFE509@BN6PR12MB1171.namprd12.prod.outlook.com>
In-Reply-To: <BN6PR12MB117124D8D3DAE8FA8B75464BFE509@BN6PR12MB1171.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-11T02:57:22Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=53ba233b-17aa-49b2-a55d-f85bf1e2f310;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-11T03:00:46Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 72266197-6804-45a3-aecd-c49f90d36e7e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf2e2cee-62ea-4d45-5a81-08d9d4ae922a
x-ms-traffictypediagnostic: BL0PR12MB2531:EE_
x-microsoft-antispam-prvs: <BL0PR12MB2531756C5F147AD2A883FAB4F1519@BL0PR12MB2531.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LkVufh2BMDTGNTILselzO5ORwzJoSFNqHmn6i5o9YDuGgHz6B3HA8hUtpZKP/SYVGP0DXDsAguxo3fjjE+p+3oR2iqkKBZ2qUfWHKIxyYCyhYalFCt2J18TSbyoKO2yPwQe8xwQj5ui4oLs9nfAi6Nd/44kPD/aE5DTz+eVUBhFdBR5yzQuNfukac6dsLiRPwq/+nK0VDUkpNlBxX8uCyAwTj0B9MFQhi4IcdHMTI81H5efEJAVFcJdqBMCBo9NasHMS6TCZG1ny/AlEeH4sMClYppcqmHWaLxnMM+U/oW+YYS0rEW+LikGne0LZz9Nb560nvvubx/OPDVJQzgFi6xCrdjtyQSEbPPeBS6rpkrabn23LYS8Mv5iDs7Gq7DDLytP1g84ZF+HuTPt15hDmSpyPNuV5IPXx0ZbE5HTh2vj8TGzmZzK7j7CFfF57K0rwA8Qk31WX6FNL5p1NC5WjYE0wf4G/4YIeMCCgwW7eedpPCYS0Txcy73dbWhchjCS3NHePqnn3MPqMKZEqOBe1Lna/OQJO0yuoyzsDyEdsbuKZ0TIj6XPx/tvCcDTnk5Czx+bWV9umtjmBAAjN/ii2OqOYKbxd7s2nOw/A/C1a/CTEmB/uLyTo+FJArU50f/i2xO+8RHx3ei9wy6PoscL+UiidZItC6MQcEXlWuyUIIEfOPYBely0BOmmdEBuQZvD7npDflAZT2Wk4jtM8usbWwQsuO5nqCjLafS/pAkruk/w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2465.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(76116006)(83380400001)(122000001)(33656002)(8676002)(316002)(508600001)(8936002)(64756008)(6636002)(921005)(2906002)(86362001)(26005)(66946007)(7696005)(9686003)(66556008)(5660300002)(66446008)(52536014)(66476007)(71200400001)(186003)(6506007)(38070700005)(55016003)(53546011)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Uky1b/restnhlEHHMu2+KnPpXReUHcrheFgIJbQbn9fPI/wdEGucvJBnv9J?=
 =?us-ascii?Q?q6RxksXOKtr4g/WvEnL57WMZf7V6CTPBQDxrxOlnR5QH4dKMAAMz98MKmuZG?=
 =?us-ascii?Q?0S8O79lRMhNf9Vdv/v5Iudg30JOAe1BhWO0Putpn6WutxGWG/7SbEmnlPz/x?=
 =?us-ascii?Q?Xm3Z2i8wNJVZCpySZL5h0OVWHd8mBYNt7//RL7Pn7xCxyeuG4zLx9gn68rDE?=
 =?us-ascii?Q?2qoGaeg+hXlHvrsOZQb8lGrAhH0bV+Ykko2Gkv1kckYEqrSpmkU494Fk5FTO?=
 =?us-ascii?Q?/C+71IyyCOYoOrgOnQ0hSnJ53Eh27OfwT+QD2SUF1RWs5yg7DQm7ggiyCi6c?=
 =?us-ascii?Q?tX3TzMExt1G4FL20HhzEuDDHGqt1Jhozgch5PZhH8ZXZZB2xL1V2DdPaqXJu?=
 =?us-ascii?Q?/KMUS2i2dqTkmgIdyB8pdbtDaXMS4qQjLYzDZLZHmp3SvSxcoO0LmphWEPTg?=
 =?us-ascii?Q?aVPBKRwj8UwQcfHfdNWoDH3Y5KpItTPihg3RcNk9F6OoZQi+EUo6cztMpDFL?=
 =?us-ascii?Q?Zfq0cdrhGSKid0rMMqopFLHLssDjjt09bW/XCI0pM1c0oQ2zC2MQIG2KKgbJ?=
 =?us-ascii?Q?v6NxXeFdOSKp4TBUsuoU94VDMUUoj+1pm1ZdObtnqBVqmenO42JYiCh4iIE7?=
 =?us-ascii?Q?aalFcn81U4OFJLSXxx6eQN1WqAfVnNJfLZuIpgptZFwCCPF3AgF04vn1MUGS?=
 =?us-ascii?Q?mSiMbqWAah2fk6G/dAhYmWXwekNhhBp+Y2yLZfgZifivFOinBD3SlW865o1F?=
 =?us-ascii?Q?72uSictdJhhqYiP2MKYX09qb+18DPfcGm63bR4Em5mImHhi+y6wncsSHV+DT?=
 =?us-ascii?Q?OwQTaAtMemfIXnszC1ESlCi+Bql2crmkAUxJhajROobYfGl0XKv75Lc3pemv?=
 =?us-ascii?Q?HalSZ3j2HS74kSVDAC4h7mu+mEz6pSE+Tejh5UEi6ksO1KKLw+8ax+9vMV4u?=
 =?us-ascii?Q?81OaB/5Sn1a5K+ehEId4peYMBeL5DS0ABmzoBzkp0msmVnqu4iJW8CnEKSlk?=
 =?us-ascii?Q?3aKi5CsID8J/QeYjeBNwJ3XUupIx/vY9fB9+yRNy+u6xuJx86ua3fAinq9jR?=
 =?us-ascii?Q?Gft455Ofiq2cSEVGNV/cIZnojSYP899Jh3B4SbaE6XD1ggoz39wbhKhl7V1o?=
 =?us-ascii?Q?vlI70cmc8LxFVB/UWkYD2yju6Y1nnRALz90DfkSupIlDrkM046j8H4pLIGJR?=
 =?us-ascii?Q?gL2vj8E8/bqevgKLizMKIOxtjZ5cI49eShKIXPmjiMA58yZbcej47Yx3gHl3?=
 =?us-ascii?Q?tr2uJxbD3aE4F/rOxAvdFrv0AuZ4fHRclnutrum0lGjTMfMtbXm+wkVi5HtS?=
 =?us-ascii?Q?oFMyftvnIcUpSTKJpSRTfnP93j/gSmD/h2jLqLLJN/mlY6q33Pjc4VlCDSYI?=
 =?us-ascii?Q?4z6a2dfwOzuqohgJ3cbFD4Wiiuq9BkS4kq070gW7rP/F0iSWlM507paU0xgR?=
 =?us-ascii?Q?nxYnKmo86S3lsLacqQKhZXX5AXPkfUXNumfuBseUQRGrwDZZBPVUG1Vgxynj?=
 =?us-ascii?Q?GnigOysOuRhtHmM956zde4dkjBTQxK83cVXjF+2PqWezx00Alo2VtdR6BjQg?=
 =?us-ascii?Q?IcZzp52cQMag8abPTisX/IgQupoEqqua4AQ6GvqXxNvzSQRiYqNsTwlDDlrV?=
 =?us-ascii?Q?Qm2n1CzPGAyxYmPDshygm2U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2e2cee-62ea-4d45-5a81-08d9d4ae922a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 03:00:48.9408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNzu2xyWghzb77NbaOZg/m1vKWu1ECVhUfCZrC92nCN7+Z1OTqVC6jmk38cqps/jMDQgjBup1WJwEIcRL2c1LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2531
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

[Public]

Thanks Kelly. I will push this patch with a tag like "Tested-by: Zytaruk, K=
elly <kelly.zytaruk@amd.com>". Pls let me know if you have any concern.

Regards,
Guchun

-----Original Message-----
From: Zytaruk, Kelly <Kelly.Zytaruk@amd.com>=20
Sent: Monday, January 10, 2022 11:42 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deuc=
her, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Ko=
enig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Huang, Qiliang (Warden) <Q=
iliang.Huang@amd.com>; Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by=
 local interrupt

I can confirm that the fault no longer occurs when the patch is implemented=
.

Thanks,
Kelly

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>=20
Sent: January 10, 2022 12:14 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.P=
an@amd.com>; Zytaruk, Kelly <Kelly.Zytaruk@amd.com>; Huang, Qiliang (Warden=
) <Qiliang.Huang@amd.com>; Zhang, Bokun <Bokun.Zhang@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by loc=
al interrupt

This is observed in SRIOV case with virtual KMS as display.

_raw_spin_lock_irqsave+0x37/0x40
drm_handle_vblank+0x69/0x350 [drm]
? try_to_wake_up+0x432/0x5c0
? amdgpu_vkms_prepare_fb+0x1c0/0x1c0 [amdgpu]
drm_crtc_handle_vblank+0x17/0x20 [drm]
amdgpu_vkms_vblank_simulate+0x4d/0x80 [amdgpu]
__hrtimer_run_queues+0xfb/0x230
hrtimer_interrupt+0x109/0x220
__sysvec_apic_timer_interrupt+0x64/0xe0
asm_call_irq_on_stack+0x12/0x20

Fixes: ba5317109d0c("drm/amdgpu: create amdgpu_vkms (v4)")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c
index 2dcc68e04e84..d99c8779b51e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -144,15 +144,16 @@ static void amdgpu_vkms_crtc_atomic_disable(struct dr=
m_crtc *crtc,  static void amdgpu_vkms_crtc_atomic_flush(struct drm_crtc *c=
rtc,
 					  struct drm_atomic_state *state)
 {
+	unsigned long flags;
 	if (crtc->state->event) {
-		spin_lock(&crtc->dev->event_lock);
+		spin_lock_irqsave(&crtc->dev->event_lock, flags);
=20
 		if (drm_crtc_vblank_get(crtc) !=3D 0)
 			drm_crtc_send_vblank_event(crtc, crtc->state->event);
 		else
 			drm_crtc_arm_vblank_event(crtc, crtc->state->event);
=20
-		spin_unlock(&crtc->dev->event_lock);
+		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
=20
 		crtc->state->event =3D NULL;
 	}
--
2.17.1
