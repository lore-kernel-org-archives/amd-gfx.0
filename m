Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937CFC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 03:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 492DC2086A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 03:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gvd1c7Uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492DC2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EDB26E04E;
	Fri,  7 Aug 2020 03:30:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 053676E04E
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 03:30:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRjc2vATZJ2g3ZTQ+X4ruYBPd86rY1+efXCJcA8vJbecCGm7cvx2jIK6ey00ehLrmwCB00cKPjWpReTlHS8NaqWf8QuQEFRJXPl016IHnsOC7aaaMJCIfDDViv8KIsQHnNmweiWORdKcAjCY+qkHdzZVXAuMnmkQO8IQUsZuCYqx+qcp9HgdvU4z+Go37/q5DXqdt9vXx6MOlgPr+Q12n2h1cSXauz6heHtlhfp0XfPowaTQUctA1P6XOSTUC0Xpgori6ukVTpbyl0fiX0hiSS9hRbnvHgYbGbqfiN69R/iNZ1SY9UcMRndKmDSjXQAk96y4dNogKR7aPWmcS4QWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfHzT8RxxQkW84Z/QRx328NNTa9Ly1rrTheUKZCESqA=;
 b=L89q1VoXsvR4kle3cVLGlUR9zrkMkD4WT84gWUx1kAIx1H/fFkCOVDaJLTLUm2eFMHM8rf8zGJiQtFwNK/isDPOBtbRj3wG7Jspq2azQENTAUYnMbdc4rT6EGiLR9gPZq3sGOh01n78DgAvVsCACibAkgwn4A+4wHHt4eSXJvtihBMBgU8Of8SzcQL0ddDctJwpcUt6sSUltYsHiuj20EgbZw2TcnBTOHlJVF5mShLiH6W59iIF83uQaeEUUY/1oHXZiFKOVJ0XeWLqPSHSSj379yKuCrt0B0xecCuoWxP+dAHNEnBitIANuWkEUr/rO/RuZBOIJXXq+Du5l1FN9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfHzT8RxxQkW84Z/QRx328NNTa9Ly1rrTheUKZCESqA=;
 b=gvd1c7UonzR2PeYI7na1A1YozAQxAswXPaE3COruMwKcEeCmmjHjT7h8dDGrzGRB/dmAYO35if3T1Cv6fTHpa7HyhEapwPHyE3WLDcEg+/I+fzt+jVaKqSoorJ+LPwUkU5E4YkFeznFQXEomOk1zhRuWWfGUX55qSsx7ip93dE0=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1349.namprd12.prod.outlook.com (2603:10b6:903:40::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Fri, 7 Aug
 2020 03:30:14 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3239.024; Fri, 7 Aug 2020
 03:30:14 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x
 after GFXOFF exit(v3)
Thread-Topic: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on
 Navi1x after GFXOFF exit(v3)
Thread-Index: AQHWbGOZHAhoBr8BFUeE3DCGPAmI36kr/HJQ
Date: Fri, 7 Aug 2020 03:30:13 +0000
Message-ID: <CY4PR12MB1287FC5B5D83952F2D862147F1490@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200807023633.5949-1-tianci.yin@amd.com>
 <20200807023633.5949-2-tianci.yin@amd.com>
In-Reply-To: <20200807023633.5949-2-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-07T03:30:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c0ede093-eb29-4ed9-a925-0000e9bb46f6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-07T03:29:54Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 187cd00b-6bfc-4cc3-b35c-0000fb619428
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-07T03:30:08Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: e4525fc1-69af-45b9-a946-0000ab364b01
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [117.136.8.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7d66b86-f4a4-49af-3744-08d83a823296
x-ms-traffictypediagnostic: CY4PR12MB1349:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1349658DC83A1EDD950430C5F1490@CY4PR12MB1349.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sATwmNRvKKsu6BOuxGnZ4s+4/9tghsjDyHcDSnKngAl5mCtqcmV1V31LHD5p25aEOI999gai+ilWS2LoLJSaTqcBhcuc77fyezROCDHqSR863SYO8cI1IlTsShb7pDho+748+qgIvb9eKvSd5ajYwx1Y2CeIxNi5+pD+fjq3pKDW8ZGgISwKdSfltV5wXCIPPfnImLBcTv3PVLFEK5WH0wzQEHvtDeQ5wLgb5vaQjkfY5qYoDfl1/4rpPxjB5yAnWxOx+8JXmagfWW73yEnClKcd3qRK3s9RtaEtkPWo0WtkVgk5FudPWOUwdkdHeMBa8yuqwK+jFnPrkYmvAFCroWU9JXRy+zCvlSPgkTcFQbcyI0UnF4hoVYABfZF3kkhkHWT+K0pOoGEp/9M0g8LQLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(9686003)(55016002)(478600001)(71200400001)(66946007)(2906002)(66476007)(66446008)(64756008)(52536014)(7696005)(66556008)(8936002)(76116006)(33656002)(6506007)(110136005)(8676002)(53546011)(86362001)(83380400001)(54906003)(186003)(26005)(4326008)(316002)(5660300002)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: iIXiLw8dD1bO7/7RjW+ZQBH7mErG+b1SE7Yg+vKgUKPgdHjpIYRm06Nj0UQQ4+23X9+8Z/wfTptzSAiUPXo2pz4z9REXP6oLw/WSD7mEDgCCteu05M0rAVtx09Ju9YFKddUp0DujyMMl5pK6z++kt0ZmsGcnH2T60i1OL8eifHsb7+xqlijs6U0RBNxGgIUFVPKVYl6REtX7xy8UPw7dubG1mbn2WP8t/XbKrgbgmwWTQufL3pWONIVQ1K/88E921w+Kp/zL2/obgJtJyVG94xXroi4oQyEY569FuEANUegCXq6FrHdvvpe4n45Dzz1AgkZOL4R4RlQQyz9aSWPxwUcs3ABDQr+KwxpMamM86I19+QnyTwRxHYuJwP+9iz7MY5XDd7pahkD70k5Oh9pDe/GQGvcyfNeXbTmVtX7Fbr2OQAMURblnhinQbiDOTEnGp27/mbK12suHt3iYlt7+ayBC83XJFmQlrpGQgtLko/hoKFGdkcFvUy5+5kGC514h5cMAH/vsR+ypkdhagxaAyWkabJca9o/A/WZiZLN+f3s0CnnCmRFB0A9aiCE7TiW9ptXpTYr7upBrAiFmYxbcmLHKaNTc4dD7EyQa1jF9KIj/rzKWeLaQPo4LjdwBD5v+gnjcSqLajJM31zn4AfVQug==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d66b86-f4a4-49af-3744-08d83a823296
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 03:30:13.9411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eqewFsFJ+IfGdXx/bGXmVMJck5yupUOBYAuIkI+M3OtZ50z8+r04AD5sXqU5SwRcNuatKXxnqN6cl+E4sBqHgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1349
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
Cc: "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Yin, Tianci \(Rico\)" <Tianci.Yin@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Hesik,
 Christopher" <Christopher.Hesik@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Swamy,
 Manjunatha" <Manjunatha.Swamy@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Please check one comment inline.

Regards,
Guchun

-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com> 
Sent: Friday, August 7, 2020 10:37 AM
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Hesik, Christopher <Christopher.Hesik@amd.com>; Swamy, Manjunatha <Manjunatha.Swamy@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x after GFXOFF exit(v3)

From: "Tianci.Yin" <tianci.yin@amd.com>

On Navi1x, the SPM golden settings are lost after GFXOFF enter/exit, so reconfigure the golden settings after GFXOFF exit.

Change-Id: I9358ba9c65f241c36f8a35916170b19535148ee9
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 8eff0173360d..9e133fd0372d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -571,8 +571,14 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 	if (enable && !adev->gfx.gfx_off_state && !adev->gfx.gfx_off_req_count) {
 		schedule_delayed_work(&adev->gfx.gfx_off_delay_work, GFX_OFF_DELAY_ENABLE);
 	} else if (!enable && adev->gfx.gfx_off_state) {
-		if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false))
+		if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, 
+false)) {
 			adev->gfx.gfx_off_state = false;
+
+			if (adev->gfx.funcs->init_spm_golden) {
+				dev_dbg(adev->dev, "GFXOFF is disabled, re-init SPM golden settings\n");
+				amdgpu_gfx_init_spm_golden(adev);
[Guchun] Since we have the function pointer check, why here we use another function for execution? init_spm_golden is one guard to indicate spm availability on navi1x ASICs?

+			}
+		}
 	}
 
 	mutex_unlock(&adev->gfx.gfx_off_mutex);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
