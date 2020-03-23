Return-Path: <SRS0=zf+m=5I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA787C3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 03:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B38652070A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 03:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="apxX57we"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38652070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5467989AB2;
	Mon, 23 Mar 2020 03:54:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE8789AB2
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 03:54:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEUOY7luVI79du1FdFNXie5KszsWPgSOq3Vnk02foJFJSIPNhZlzI/UMZ2ullpDWRlv2HJGOyRxNW8tYD6hKEJuT+PFz7DmLcYyACd/vbZ3p50ClRVz3c5dVUCEc0nr+PHO5MyxkLwZ/ApF2KAuO2YEqmFiDxFMj1cWM5KvkZo6aKhIm+cGnAEcE9bLXbkyANSqlcWbspiv2oXJghI6EklaJy+SFPkH57Qz173P/NfQGSEACwDgZuRsiJDeAPBZChn6mxDN0m+YPAozNdncDV2kKq6iI5kOaHMIszwOTAmncpNyI3ud+P15/+R0xNg9LyKDKj97IZ4FKkD5So51syw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ODMxmdTP9cNSzI9y61jyKX6uXMUBrbpAiAHmO65e34=;
 b=aJsJs5w0Hk+xoDUKktG9CKOGfi9u/qAwt9zwpFe/GCLs7MzqserefYUFC7d6VstVQ4G7do0jZPaqtYAIrtC+tEv5NKKmywnC/BYs2Dl3tRk591wu/vwtrPEpia8XsISULCIi0R/OuVrvvtr5MWvemVNV1tGZVzvzysmNycb/tttXw4Nren6kVZ3kkb6figxrbspksGnkevKI5pe4/qi3URm1zedK49WSYl7iKz0h8k4D5ap8m7KG1Eag/VL1UwYN6ZsJzeZPgCEaokRw0uYQXgQq9cbBr73F0ruTCbCEwEhhKouZ6l4JJEHvSIunCZt1xfbif0qBstPcXshX0ruOtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ODMxmdTP9cNSzI9y61jyKX6uXMUBrbpAiAHmO65e34=;
 b=apxX57we19zeIi4l69nCyH9SHWgwU1Zh0qRjuFbR1/O9zLN1wBjcdRBEJ1G9oTBaYk0Zq6Oir8hDYDyOKi/UfzCHlG1lOges9TLxR7TlO/NdRwJGxeDtcdGtnL2wCc2PWP14tsXNbT7GPUvpIhQAZShPE9Q6wFomCOd489kib5Q=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Mon, 23 Mar
 2020 03:54:06 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 03:54:06 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 8/8] drm/amdgpu/smu11: add support for SMU AC/DC interrupts
Thread-Topic: [PATCH 8/8] drm/amdgpu/smu11: add support for SMU AC/DC
 interrupts
Thread-Index: AQHV/uVQMVz7hXmtnkqZ0cgC6mMsy6hVj2QQ
Date: Mon, 23 Mar 2020 03:54:06 +0000
Message-ID: <MN2PR12MB33446A1ACAAFB466670B417AE4F00@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200320182727.3805-1-alexander.deucher@amd.com>
 <20200320182727.3805-8-alexander.deucher@amd.com>
In-Reply-To: <20200320182727.3805-8-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=65fc993e-1259-40b1-a845-0000296f78de;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-23T03:53:20Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a9097179-5ed1-4ba1-a8f2-08d7ceddd5e3
x-ms-traffictypediagnostic: MN2PR12MB4046:|MN2PR12MB4046:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4046B82F644E56A5E9DCC456E4F00@MN2PR12MB4046.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(8936002)(33656002)(81156014)(8676002)(81166006)(76116006)(66946007)(110136005)(66446008)(66556008)(2906002)(316002)(66476007)(64756008)(54906003)(5660300002)(186003)(71200400001)(86362001)(26005)(52536014)(55016002)(478600001)(45080400002)(9686003)(966005)(53546011)(4326008)(7696005)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4046;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n88RyKh8VsvyUWCe333y3FYYDQvqAmWPZorvstzs0ALjis6MRKhlWpZWm52OHT2+Y7eW4DkYJBCeDhVm1sSUOSzkjYq7oQ19O14Y5tow3xBxZ21ZLWX+yiHEF3ERgzGhDjjOQ/ZBXLrnRVx76Q4QYm1fWq5+yODloYKm+dzvro0J8HuJC5oR6DftiJaOpCIZiQaxNA0NgpZn725Q2n0xZC+yOONifgQLOet4JnoZtEw/S58Yi4Sn5JvslMsafQFX/8LAi+SGL8+64C/C0uYl9wn0QR1Ca7WhVD3sU+ThIe4FMCGefr3dqNBXkr1YME6qBmz7kM5kkhsHmP8wJiHfO3tlJlc4WcmP51BEbhi+gfLeGYBOmy11dZGCjywswIiKweFoOUzrifFDnEde1flRzyqPWW1yxOsiCz3b6pTIIzWdY91MfGVXutk7QVIQl9wcCqxWcXwjWxfp4nHJ6NathQ2v+qO+tMBe/g9NGC1Mxao=
x-ms-exchange-antispam-messagedata: Un5ApI7E9tm/NKgKVHQsTaU5eWF4CwYsp7knfJPzErycIKZrBIJo1bkALRjeNZon7YYhNU6Orrqw7yoizceyobOo6Nl4kXlmPGZX92g2bwZPcA6FEIVLp4tsx9O3TEO+uPlrB5H5JY9xmq98qaqpJg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9097179-5ed1-4ba1-a8f2-08d7ceddd5e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 03:54:06.4947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+azYhT3jFMf7RPcemEhVQeTmeD76RdF5V2xxW9QShJyGqm375SjPCIIGW/OYWB6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "mcoffin13@gmail.com" <mcoffin13@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks Alex. The series is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Saturday, March 21, 2020 2:27 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; mcoffin13@gmail.com
Subject: [PATCH 8/8] drm/amdgpu/smu11: add support for SMU AC/DC interrupts

Driver needs to send the ack message when it receives the AC/DC interrupt from the SMU.

TODO: verify the client and src ids.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 20174bed11ce..d19e1d0d56c0 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1525,6 +1525,13 @@ int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v11_0_ack_ac_dc_interrupt(struct smu_context *smu) {
+	return smu_send_smc_msg(smu,
+				SMU_MSG_ReenableAcDcInterrupt,
+				NULL);
+}
+
 #define THM_11_0__SRCID__THM_DIG_THERM_L2H		0		/* ASIC_TEMP > CG_THERMAL_INT.DIG_THERM_INTH  */
 #define THM_11_0__SRCID__THM_DIG_THERM_H2L		1		/* ASIC_TEMP < CG_THERMAL_INT.DIG_THERM_INTL  */
 
@@ -1558,6 +1565,9 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 		break;
 
 		}
+	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
+		if (src_id == 0xfe)
+			smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
 	}
 
 	return 0;
@@ -1597,6 +1607,12 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
+				0xfe,
+				irq_src);
+	if (ret)
+		return ret;
+
 	return ret;
 }
 
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C659315d457244e756adc08d7ccfc6dab%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203256919711120&amp;sdata=YM6rLmsPSMvUxiSxS4b4qH72I9xojvwi5QKhVnmqk0s%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
