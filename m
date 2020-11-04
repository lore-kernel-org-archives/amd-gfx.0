Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1995FC2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 06:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD5A208C7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 06:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qomB+nUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD5A208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00FCE6E94A;
	Wed,  4 Nov 2020 06:19:15 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2083.outbound.protection.outlook.com [40.107.100.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A486E94A
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 06:19:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHooYxFgiMnnXsAO0PDnLP6o5oCsPPtpbY520MInHj6OqCkQL/zvgR/MnD/4wMsuikrwk3Ef7Nf1sTOc7Pkuaami45ESKh5LkM+M4eYs2JjgFFt7MfdFGrxXW8FOdzqE3zNHri+HOIwYAzIbV8V4eJOMs3zV2BsDNO399l1rM1KEo67G2We7BFHwKDR2IkOOdK7OvDSsPhvjCovkvCW4mFiB9dqGjzNmF3Vuf3ceD224iach6Rt+E2D9bzLqqST8cg/Im+TBmfwd0d3AmzckdkyXEivVMfB2d+CfXfmxEAXqFeFk6AvbyojtJjKLrFE5p19seHcw3yb6pqHRGT5Rbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jvIcy4WjHrHworeEUaY/3wWBHabfcFOJxNSktbF/co=;
 b=OeckRNr43IykV4bFzEUkf/HYit4smzeUhhTTqP4jwzogBlmBaDpEw08vq19GYGF7aAvp4c/9mb+99UArw8/Ak7dNTCRtw324Lg2NTbVfRvvU1uT0M7PdVmLnVGSu/EUtAkeWxF3vjN8aJ+TN36c3CX0jHxX5WEImVRp9xyZZWjPQEyl7muOe47U3zeFEdUwF3JoNFH0dLlUzQNu+lbHMbLA+aLizwDgWezqPPLGI9ehXub2tHfX59k7vlG17cbPg73UGZfkgLShQBFyvMNlC5FOUyRxBIa8/X86ft1TlsT7UD5pFt3gyG+38UBXOUDWhaop4qFSh+M2v9JCU/XM73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jvIcy4WjHrHworeEUaY/3wWBHabfcFOJxNSktbF/co=;
 b=qomB+nUTIcSULjpFvptN/kUjE2yLHrImmEdAYDhW90+2NjJTqPrgrz01tpargSmuutSQWysefyGoyNMr7U+0kXAaE3k17GuCgAC8c9jsmVDo7q1fb1HuvRFGs9NTIPiaXu9SMSM6TFT6Y+SoDxx+7s2F8xI/txxPFXV0Jq3ltZc=
Received: from DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) by
 DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19; Wed, 4 Nov 2020 06:19:11 +0000
Received: from DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf]) by DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf%6]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 06:19:11 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: cleanup debug information in
 amdgpu_set_pp_features()
Thread-Topic: [PATCH] drm/amdgpu: cleanup debug information in
 amdgpu_set_pp_features()
Thread-Index: AQHWsmhe56ecKjLGo0Sbk61Dx23n26m3f4Tg
Date: Wed, 4 Nov 2020 06:19:11 +0000
Message-ID: <DM5PR12MB16571EE768ED5E526C256DAA8EEF0@DM5PR12MB1657.namprd12.prod.outlook.com>
References: <20201104050609.20571-1-kevin1.wang@amd.com>
In-Reply-To: <20201104050609.20571-1-kevin1.wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-04T06:19:05Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=af297875-34f1-45c7-b66c-000059ecac31;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-04T06:19:05Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 1b8ff4f9-e07e-4754-aeb8-00005b067752
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45d6c34e-8832-427a-86b1-08d880898bd1
x-ms-traffictypediagnostic: DM6PR12MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4497EBE59D6A447166D529948EEF0@DM6PR12MB4497.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bez/8g0covHxrqQ/M5NAdsdiReKZVz4nwF96wkmeiYPPuOMVpBGEsaEYG2o36JBwgEA2gX4tgwAI/ooHtAtVjRDCMpqlSdBaPcR2meRePlzE1HEEMRFWyPBpR/t1xHE+llDV+0I3/eQX8HsALEEH//MpVdmF82JUnwE1KstkBbbUhOziM+5Ih1f/l70ETE+pmEfXmdAjB3yXzqrqnVC04B/ZQMRK7wbwKLs5k+9Oem0gaCysx+trW5e5T2+WYODDMxSkf2RQ8Ze2t134KF8hN692gy0cJe+BMU86FKw4qFrcq1+ELPYduKjzS3QJpAHxguGlQjnqijgI4Pn2COX7tMfjKVnUaJCY7LLxwIeX+HA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(26005)(86362001)(316002)(4326008)(54906003)(66946007)(966005)(53546011)(6506007)(9686003)(55016002)(186003)(76116006)(478600001)(7696005)(110136005)(33656002)(45080400002)(8936002)(71200400001)(8676002)(83380400001)(66446008)(52536014)(64756008)(66476007)(5660300002)(66556008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: o0eaI1syfQYEIpWLnEJiq3P12Ctfx5AWmc2PcsSHSbHWothfpCNSLcYsAdGMWwrBsiPeZ1TMDSjudHg00cowyYVwvBCQZSOF7a441YosbiRa3u2f9drWps0hTVWG/cKLofapi2Uwh7KT1ykhxZHc9uU9a9N5sSAV5LpWb0IC5bFJcA+g4NnTjCFW7d4jVfpCh9xcuBK2T0vTj/bgald5xQuWNtGAVZSKAZ+1iV29XunH6rRCCCbleQjNMGZ/JYc37BAc56F+HZS+kZpJpjraIHxgeRo5qGDQrMvCqv7HwhcN73t9ZPLs/4XQ9TbG8Zzeko8aanixRqr0Ygvp8Ov7KxBKPjql4bM3KquQtq1nU9FAn5yT2dCsmjbt3O1MmR54iEWsuFZf0yjU1RbHcO3SWLPYDtsnlZ2rUd7PP5CN2J3F3WtZkoQey6ApQRD3kGV4XJ7tby/RhakIUlUxhpKpDYVlIb/Ku4wVl9/M5M8XNWbDY7qGHsPeSbRr0bF6ttF/ellRyIButsjyCbECO0zAaN+F19eONIBQiLtaI0p+1NMGMTzThi83bql6qHGC1yuEdePf8Qb1s9jUA4Pr6u1gdmqhmA9pZSQ5GKS010Z7iVjlDbZIKdF4X5MEZir/tuumLFu2qQqbXVwO9AHDEAQTHg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d6c34e-8832-427a-86b1-08d880898bd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 06:19:11.6874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KmllxMz7Xx/j3FN0lDlBVu8fnk99NqzhN8VkB/cBqjko1KbtPbFwr4rLDdo+bx/I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


Best Regards
Kenneth

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wang
Sent: Wednesday, November 4, 2020 1:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: cleanup debug information in amdgpu_set_pp_features()

[CAUTION: External Email]

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e57153d1fa24..a33b1cc50008 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -941,8 +941,6 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
        if (ret)
                return -EINVAL;

-       pr_debug("featuremask = 0x%llx\n", featuremask);
-
        ret = pm_runtime_get_sync(ddev->dev);
        if (ret < 0) {
                pm_runtime_put_autosuspend(ddev->dev);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CKenneth.Feng%40amd.com%7C5901989dfa2d4f1b8c7d08d8807f6546%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637400632388372699%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=vkjpxOEGhJxk5EzDweusO9nEqEVjKJpwY9WsnHma2rg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
