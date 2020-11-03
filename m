Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFFCC2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FA920786
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3hhvzVSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FA920786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CE416E858;
	Tue,  3 Nov 2020 08:28:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6B96E858
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 08:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOGAYifTFpvoiDc0AuYcwD9x24Gtj8IItATrAahpy6DuPhMa6JXt+eojRVCzjLJItlxRXQOkcx9PLfwhbubJjVwuHI61T7jY37oonwQqnDMccaHvm7ov7i/XodWNkBV3wdgDIx/rYN6e7agpHER82HxTIFQ3EKVWodosUXZiKmqLW4wOXLPbWeE6hC2GMrJeEgHBe35STk+xL2jGtB32BRMAFg9UcASirJQh5QUI2o4lkR6fiUx2sz3xDW9BV6VMLaJk5q8wOH8MIFoJ9I8RHMkDRY4RqbpXcGkd5qhdw7WhSCojAUkUP6ATCUIfliUPhsDhXHWOM4IArbo3D/blzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jby5BPIsK50VhizjnQBTboWQ0qosd+t4HMZrh+EIUVg=;
 b=eQJV9d6mJ68qRK5Kf5eStAStJ7bemTVHji5keuRqunpzRpeyfqqGJilpqm08ylKeEzVt+2LRyt3/w4siu4oaYUA6+QYoGmZhwVG761q6eiLRjtxXHNaDKx6GwYmz6Z6zpggGXTdPZMdrwAIep7X+HARpO/HZ7qcejAHYtaKgFLXTOvALSaLdmsejULMnhviP8eH3P9KSgAQ2KVoFAT1qtX+uAqSSG/qMaN+eEi7tnKkUsZTDe7Pch3I0veLWTBXZxsJRQR5G2btTGdyB5zQjZyDchCuGyvhj8XZ2Sc9Z1YfdlZLnzZ7dEaAHGPz9tZ0ncGSGu9p+1TQL+GF3CoN6SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jby5BPIsK50VhizjnQBTboWQ0qosd+t4HMZrh+EIUVg=;
 b=3hhvzVSm6R2Q3HTNgq3nDQMQWzYZuYFv/vuWL3NlYybBDXkQ5OTzym3RX7uFO3EmorWu2VdHKRZNNhvmTTjpH/fgEO+Z5ycND8zV6z04NcD0nXReC+xRKjyQXs0W7ovagweqBIppFMZC5DY0pgTmsmjT9KoKyEjxMEstCXmekbQ=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3180.namprd12.prod.outlook.com (2603:10b6:5:182::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Tue, 3 Nov 2020 08:28:12 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 08:28:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen, Jiansong (Simon)"
 <Jiansong.Chen@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable GFXOFF for dimgrey_cavefish
Thread-Topic: [PATCH] drm/amdgpu: enable GFXOFF for dimgrey_cavefish
Thread-Index: AQHWsboa3GeBQfteZ0mGEAT80cokp6m2EuyA
Date: Tue, 3 Nov 2020 08:28:11 +0000
Message-ID: <DM6PR12MB4075582E1031D45EEECD6CA7FC110@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201103081936.7054-1-tao.zhou1@amd.com>
In-Reply-To: <20201103081936.7054-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-03T08:28:08Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ffd5e4cb-4e0c-4a65-8d7a-00001c036524;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-03T08:28:05Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 2d87cb67-48b8-4729-bad2-000073076ec0
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-03T08:28:10Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 6ed73221-19b6-4ac4-9387-0000aa6f80e3
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5af3cba8-9d49-45a7-e6c5-08d87fd266ff
x-ms-traffictypediagnostic: DM6PR12MB3180:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3180230C595B3618E6773F25FC110@DM6PR12MB3180.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k7Omp+uLMJLrX7cqm4mutr+1me9IllA9CEpwC+cd9PztV5ES7OwcQIsRcZRieBGQoQuqLO2P87/DpGphwwmvJjAHO0zgC/TgR0Bl3CViQmfP5kNW5v5Nw/xEB5Yomzsl1C2eR1Mcz85N0NTC7wd2mSOfnivk0BlZ8BgPODWWcqwEKWVMFr1WRfRzANu7iF4f+djJXtjEjVsNMilhz2QpFjFrXYAhUHkOo8Wd8iTuFnHz5wzR9MSLRzXRYgFu4X3u2u1y2hw+SfTPX0QHtd+cE8vTlajARHLGpSGUHkV2qaecCE+OXeJw5gz7JZS9r9RyumHpLVt+VGFSQpSUpjQRYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(2906002)(7696005)(53546011)(9686003)(71200400001)(33656002)(83380400001)(5660300002)(6506007)(8676002)(8936002)(55016002)(86362001)(186003)(52536014)(26005)(66446008)(110136005)(316002)(64756008)(66476007)(66946007)(66556008)(76116006)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: UBowGyjupubnrVzWqcvXj4lT+tdN2Bw6n6M2QrRJ/Wbw1Us6evpJySQ20FLZ23w9zqDE2wkHliwV4rS2qCEnzlG8Wb3zPUzACadwa5XeWjJr5ohoeYVfbCc4YwyH8drA2jNBPk3r/0OtyRdg4bfInOmF8ImyZNBpQAR+KFbHNLP7gfUdGCJHnHWzgd5JxuXCusv/SlLzz0RVu8g3lkzzGixmdXcdQ92ieqI2c7z4KSys0pOEXDXhQ60eVALgZIvsgQttKmwmfZAeu2NPfaNY9N6ZgSq6CAQw8zEhNo2yNujQ8Nt0Wq9Gpkq+w0Bs19gf3ZTuT1BqJLSfplGxSEfQ1dWtoaYdT1jBG6lDpyuGK1IFJyxFg1Blho77dFAFOCQxdDA0U/pFhQCrUVd1zaFgmAUooh4oQTcUZL/JeRKWYGbl/MHDtvYcW7qUaTf6d0LNbDHRMWD6HQ8U4IXNYKcAJNM1rqiEs/uui8Di3i3ffOoAm7dP/B7P6JejfjihgDq4MMZD2SD8f+/5IvN20nE0zapPrrDUhcvxCmgyy2Sxrv1cM21Js+LgxrgO8MS7v/hDKqIbwYQysU7hkHnojdu8AuyurNg5Qummn/CyVPnOWOR1G1GD/M4DklDk3ewXbd2UKcs5FEeChpwVVhX95xzFsw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af3cba8-9d49-45a7-e6c5-08d87fd266ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 08:28:11.9159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/nk6Jtdn/Zf1v8iiHwajuPlqAlqIvFJBz8krjvYDLJUSd95tqD+DzC68h7ie7n67SVFancBImbse97BiIDi2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3180
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
From: Zhou1, Tao <Tao.Zhou1@amd.com> 
Sent: Tuesday, November 3, 2020 16:20
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: enable GFXOFF for dimgrey_cavefish

GFXOFF has been supported by PMFW, enable it directly in driver for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c         | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 76eba25b2d9a..e153f2719f79 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7808,6 +7808,7 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	case CHIP_VANGOGH:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index fff1d2522463..b6453ee6f8e6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1086,6 +1086,7 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
