Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40D7C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 13:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8834661C98
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 13:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8834661C98
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38DF76E4B5;
	Tue,  6 Jul 2021 13:51:38 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF136E4B5
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 13:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRi2Uwe4Mrw2mWmpbJJNlQI8jZuAvP3WR5NPQTLroppkI+8pr5AuCrb/pmCiBOUqvbhlyHnHnxIbGqVsZ+hX+ymj0m5Spv4QOhd9yTMnDQcMBS7L53mHLqJE5x4KSzIAkyyeoclu8yof7YTe7ngHUqTHLTaCe7vuH9lyUDh9u3L81gsRG8ElXF119n7z+aD67fslucZjYo2cIi2mZBDIuNeBwK0LUf0YKV93TZd0PMe+lIua2q/zzGPxQYl5nVSN+0qFmC0syauu16X07iamcnkd8880Oal4R0Mya0aha7ZYHJjaq5b++Yg5Ey9FSTGv4Lqf8BaGOOJ1E3wM61X/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FfNo70nctdBkKCQ31wIVwXxIC/vPFSZ9YqYtmMayTU=;
 b=UhCwKu1VRNObXjalCebdCuF/tSrl3qWT2w5/EONeaCgYpZXFnURGW00KThDgdF2KYm5iiysdrKQsaE6vWp8Rt/7kc2k2J0JMX+DIyOrfy/RZ6Zsy6c9dVoM/YQ3FXeFvb+zqBIAh8T1CsahGqekBSPUqZ+b33tZ2ciDJcfETQPg7r4JWbc+zZ+2fPJXBASFqHslOpOlLqTzxA06iMFM7ukpS1KkHpsBzZCOxMfgCahrlNxQpuxou0S6N3v3wKE6MthACsSOGAxQNv9puoQh1Q0/y4a2lrvtZ8VziqoPpSJ5LExeqalitEXJ1DyXXZpRhNIMok17WdmrGpMHn2zcWPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FfNo70nctdBkKCQ31wIVwXxIC/vPFSZ9YqYtmMayTU=;
 b=UEgEb1O6JZ/YxOOlfHlVlt8NMDs7V3zoH6P31jV+aAvrCbmOPl2Go3VO6jx0SB4Bvsi91E+ipY3k0527uciF1a/CChgCo0QO74QqbCsyolWXEFobXPjTqcuAjTq9LpDGn3BAr4XKXmQsayzqvSZd7S387iWJCcJ2R0/Rndl3kGM=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1623.namprd12.prod.outlook.com (2603:10b6:910:6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Tue, 6 Jul
 2021 13:51:34 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::2cb6:690b:e6a0:d008]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::2cb6:690b:e6a0:d008%3]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 13:51:34 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
Thread-Topic: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
Thread-Index: AQHXckAvR1zOcBiZJE+OMptfflPmzqs19zvA
Date: Tue, 6 Jul 2021 13:51:34 +0000
Message-ID: <CY4PR12MB12879CF8864C4F50059C0058F11B9@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210706082312.71013-1-Emily.Deng@amd.com>
In-Reply-To: <20210706082312.71013-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-06T13:51:06Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e4cd5145-7076-45bf-b189-39a79a7c42ab;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13b42e7c-2736-4bf1-39b9-08d940852b18
x-ms-traffictypediagnostic: CY4PR12MB1623:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB16231A9CCE53A51A899C280AF11B9@CY4PR12MB1623.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MnVM5/h4Z5IDvtbGDXdYWlttbAmAgAGaRIFOIa4Yv4BOes3JczRb+o1ht1I2t67+1OHbXWz/Q7hgAJ7PSD0Behdn1fnjIXTFBJIYfR4HZBglA+RGWbzyX4Gv7TZfHWrSYxre5ItrKpyYMsnxNmhOIaD1u8TFNOptFRnTjOeiYnZZmiuyvSfBB3jmegwNY01O2SRAbKmCO47NrPTOKGokO1cAtDwzdwLLqVVoF1roIZ2n0wyGqEfvkuSNV2HR2q6MI9GIZXlAeIFJDQeCKKi6YFXTzO6VEgVfF8M1Ogxr40bdDo4tbuqtGJl8wLoSbnxT0wxBrFUtH6xkXIx7Su1sO8J8Pg9SPybD0M/6hdqTgByc92VnGLBfPf+jx2lNqfzIo1Rtlc4c4nVhoMXKEewsukndDxQnaZCxeJi+uqb6S+Ps903H6H0y1KF7CdQLWgpvUVrKmELno51hrkWn2Vd7HDyy8XWSj7FOOad8zrKmSOLKdKMAPScLXTN2Y9d2WaxUM/rfXE6zJP0IutrsNVRXOwoTjP4BIG1kVvMeAq1K5Eamb1YH0KwaSMuL6JVR5sUjslLH4RMfQ8dpEHehp6A00/OPLLb/n+X+Rt5qMmc3o9b/444n5uJLKvu8/NEiKfuzSQ20nst2y+/92au04LEDEw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(110136005)(71200400001)(6506007)(53546011)(316002)(4326008)(55016002)(86362001)(33656002)(186003)(26005)(7696005)(2906002)(966005)(9686003)(478600001)(64756008)(66556008)(122000001)(83380400001)(38100700002)(66446008)(66476007)(8936002)(52536014)(5660300002)(76116006)(8676002)(45080400002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EBj2iw/4HhtFAVL5FP5dPJ6cFfuoh0KuIMKrewUSK4KEP8fbNtZ88k3K1Dd7?=
 =?us-ascii?Q?P4j14Xp1UlsF4L850cU2lPsKyummKvpJKyG1noSiFRXBU89+QitvomNdw14y?=
 =?us-ascii?Q?daPKcaBeIFlAwOoUXVvE7JFZiGq8TnxHqsAtIu2h05ZmaEAwggVXgqekZEAL?=
 =?us-ascii?Q?tqhmWtlkDBe1qC7CbtSJak066LsUEnPWEPjZrWS0xcBcd/t43BgxnOElB99X?=
 =?us-ascii?Q?tt2o1kPBb+2W5Q3WOoGnaHK3C+uSMaXdqXKO95tHAh6o5zbQ+vJbdrTt+Uvu?=
 =?us-ascii?Q?ajr70BkGA33y4RnJcWlVmRKoM+/qksAIRBWlNzCrAUBDUo3WnFsiMPV66sWQ?=
 =?us-ascii?Q?Z9SGsSNXYY/htW8O6gIs2BESWa8tl8BwA4H4BK4yHoVTG1Z98SIldQHwCW6C?=
 =?us-ascii?Q?qQXN/6IrKk7suY5TVWc3kJka4QbqGfzmfcYBUm0n2+lXyWIR8aCmdZ9gQ9P2?=
 =?us-ascii?Q?fAhfsT/ZmxVAIjsHG84zanRIqiYtr3PlTnRCyqYhu8F/ak1IIxIcpe1DEyIX?=
 =?us-ascii?Q?wx+vBAWpdKDQsVc0WdC3gcrZcC6wCJJzXZwxYmK/uFY1SbF4vSeENlL0Dix5?=
 =?us-ascii?Q?8YzwkSkC5bf50Rq/Fxs9hPO5+0wFHTZRSDcZGMFpbjAmu99DTDx47Fwa2CF6?=
 =?us-ascii?Q?KnliNnRi66lwlJKr0etRhYzzIWgR9sHscoKovrDxWc4/7ZQ+GTES+VMCWZab?=
 =?us-ascii?Q?E9HZSqxvmz5UAcBrBlpEVadQ7fItn11/tCmYB1B9RIDChCDnFx6cltb0boTl?=
 =?us-ascii?Q?pDzn4ZVh6Y9Z6GflRU93aWo6Z3SI30DDUsdmwRrpGWGayOME/1MWR6csa4Jb?=
 =?us-ascii?Q?KhwNJKfntd46Ca5rJwqqjfIg4jqGRCz6P2BkedTrBiKWHftTSpU4yuDc9L3t?=
 =?us-ascii?Q?sGhFKs2iSIgO1cw02scaOM9ACmnAh9AJe2wqNdklSw6LtpP/qC2AqFP+xWPf?=
 =?us-ascii?Q?UVC7dV3q3Vhjxlo9/6dYhvGCbvtEKOSGzDT6hT8H4zAl9eZW1zatkaTV/jc6?=
 =?us-ascii?Q?BqGUYeNYxYO9NNXtt1z6OBEJMoFkONpGRbNOTkTphxG+RvZ8GvDs+13YP42h?=
 =?us-ascii?Q?o4NJAKLk0x6Wc2OF8r2a4M3WmxuLks/ZJyTWGnAOdZFhFP3IhKMjpzGhrBsU?=
 =?us-ascii?Q?m43TXhNrINhOJo9s6oyDOl/9sa2eAj6mHVtIwX06g358ZIej0DRpiU/4wKwb?=
 =?us-ascii?Q?/wHeuVuYHaeDj9WIywFtKwNCG25T/Foczv9OnU9io3/QR+C3jH8+PQOC9uHo?=
 =?us-ascii?Q?eBBBLtrOFvQKN2+NOkxa8gFjldULGgPNnf/L2MKtlhMkPYpKpfUGrtacsMKr?=
 =?us-ascii?Q?O0iQVWqC5eCJbfZvPaENxOCX?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b42e7c-2736-4bf1-39b9-08d940852b18
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 13:51:34.6522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbfDGph8hfIvytrMqvEZdmzejTjEDCWWsQoEZw8nTZxFhIFS4XSgahQGQ7XdjDQ9wckdrXt3yhEbriGE9j3Lmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1623
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

A spelling typo in subject.

s/ctrc/crtc

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily Deng
Sent: Tuesday, July 6, 2021 4:23 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc

The irq number should be decided by num_crtc, and the num_crtc could change by parameter.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 33324427b555..7e0d8c092c7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -766,7 +766,7 @@ static const struct amdgpu_irq_src_funcs dce_virtual_crtc_irq_funcs = {
 
 static void dce_virtual_set_irq_funcs(struct amdgpu_device *adev)  {
-	adev->crtc_irq.num_types = AMDGPU_CRTC_IRQ_VBLANK6 + 1;
+	adev->crtc_irq.num_types = adev->mode_info.num_crtc;
 	adev->crtc_irq.funcs = &dce_virtual_crtc_irq_funcs;  }
 
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Ca4ebf76a046d421cf07c08d94057515e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637611566042100458%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=kh2vwkTyod4ajvt03GB6%2F%2B4FYc%2BwZLCC%2FusgWuijPCU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
