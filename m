Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025DEC7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 06:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7672410E29C;
	Mon, 24 Apr 2023 06:00:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC3B10E26C
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 06:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHS8nvyXorfPLgHoGA8OyAlHzhkLziRmfmQ1pF42mxEmPgK5t/9tT9n2gamTd63Sa6AwFzDbljWhkI9ABXxWOpendqI1n/7BBGf+hl/IRnUux1Nxs+UeA6sWizr/S1lyAuP09DZdESvs/tYl1Ktjpp/tZEwi+tZLHiwuHf3B2sBo4Kzv7NZw2SVPNizuDq4Y29BLn0gS+gmCJqpVTidKyDUDhb+d7WKuG10ALaRrI1BYf+2vL2PNvw2djKQslfBDz6/b1r3ejaQNd69fQbB2CHqMEueyXtMaQiyLBee8b73XPCWR8KWPCKyZjsFaTUQ6Z2EsPMB0clGsAhQxFoHp4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCJrxfGGpM7LpePrtGCVsmpS3noO50SFJRZ+QGPwxuE=;
 b=hNXz+2h/4ppk/jXepSs9SZKdBqgaAfWwtok483f/ERTLrxvDZZ/z15QBGFZwWVJgB9Lj0L1OTbpNqTCtvHSLWjLLbZSvmwRStKdJTWays1NYz43GVAXdB7oGfRpRJ+6FGFLDvL0vyQ92OeFqTg5QHl20KE6H7lu62RecMQPCboRbCugD2DOW/8SFUz/Z86Gq4ZRBbNQPRTHNn7ItmFb/QYmZy4xNs36KSwmniItdsO333Or9BhfYArMg1mWpyOjF5WA+7zYS6vtzVvkWaPJM2LDL7FSgeAI7K77nJCmOOxbeGWZXKTrftip4qS21+aTBrtfEwtlxch6pm4E0QNU5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCJrxfGGpM7LpePrtGCVsmpS3noO50SFJRZ+QGPwxuE=;
 b=PjpGAMlZ2UTC7W7ql4HjSLFk/oXoct3BJ7ArPbDyEVc2V22ja2EjyPyXXiRqnPppJ1ykWrbiDUiOD9LLWmqcw9K4K5iXy+YMyBPfU5xJdkXA8ImTT93hlYcAec7ZWrVb1uTz8xXLBfCFvDObL1pkzDKjNwhzazbdv++/aE/IIFA=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 06:00:27 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::1372:f6c8:8479:a4b]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::1372:f6c8:8479:a4b%3]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 06:00:27 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Li, Lyndon" <Lyndon.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Fix mode2 reset for sienna cichlid
Thread-Topic: [PATCH 1/2] drm/amdgpu: Fix mode2 reset for sienna cichlid
Thread-Index: AQHZdlA/7yBXswOsjkuMmhMY7A1D7q8593hw
Date: Mon, 24 Apr 2023 06:00:27 +0000
Message-ID: <CH2PR12MB41522F7F0BDD3784E8444134FE679@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20230424015805.78747-1-Lyndon.Li@amd.com>
In-Reply-To: <20230424015805.78747-1-Lyndon.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-24T06:00:23Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=60332b47-4c7d-4fde-a984-bc01025c2374;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-24T06:00:23Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: cdefc3ab-7e89-4905-8256-24f689c24af7
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|CY5PR12MB6059:EE_
x-ms-office365-filtering-correlation-id: 034937c3-3c68-48a2-ca68-08db448933c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFmmhWhZ1OQAiuvVq6th/uymAiUTUWrYi+UlR3Jh5RtD5C3LF1ijot4rdlmqLcV67EV4kMGQzQdfLzkvzpUBQ+gBRn0sQTLC+LMqBV8y9qjMJKSry8nUYyuXUZLMIwYpndimWM+g/N1IBvP3xR2cQpbAOF1qtUJ092+xcy7wcbGae3owQoWjLuceJPzu31XpD2D9uHZv1hnp0kQ7ezXFYQGK3OxCqHPk4idh8ZBbCn5a1IBNKEgkq2Kl24RmC4GJ92op85zwWxFKNtsO81UZxhY9Dx/ztFmGc9D/uU4V3Khyc7AAtKx5zp0V79vlGGx80aeSGUDs3g7O9pK0D41Vl15gdqXQUI8YqiJT/GD5h82aLzDECvbzvdFUEczkkqcYBIb844vKqxpNgFfICxbYTABqvkhojWGO7giTU34feMK41WpT4qbEyE7W3nBppO3PsCAHG1W3mKaVJIEVeFL39Xg28xIIPWMO2AB8mrBtnF6J2MIRiMkhzzv1AgWm22idQmL6vks+6QWF4UMsyxYcjwk/AQJxWW2SsjXE/nXkGWty6QDqPfUow/bxEL8lBrUGHGDPTwHvHTVYofWMATJUht5RYfh+nLJPgx58GdME3PzWRH1UWPeFpZa0CVYc5hWG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(2906002)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(4326008)(52536014)(8676002)(8936002)(5660300002)(38070700005)(41300700001)(33656002)(86362001)(55016003)(9686003)(26005)(186003)(122000001)(71200400001)(53546011)(38100700002)(478600001)(7696005)(83380400001)(6506007)(110136005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xLa41tO6Aa+2uaD7cHIV26aImgVRGao4JJpuKZURxwgjA4YdHKTHmHsq5kUB?=
 =?us-ascii?Q?HBb9B+WNiSNcvVxazdlJqEmHbHx7yqJAYLhuXG7T9jmklvSBX2AcwPWXEDk5?=
 =?us-ascii?Q?nGaY8S6vuY0Cilkl0UKV60JD0G1R89u65JBCEq8q8YWYxYDz3LIk2eBYcEQd?=
 =?us-ascii?Q?pOzYMzzaQwWnZQOAh/G8gI2l1VLN2XXPb12yE6Us9+6/92ZVB+SWahU54W/u?=
 =?us-ascii?Q?lQhUXjKBjrGJOZGZzronnaxako5SILget8UINq2BJxqAYxVuhn/DGC/c+vcE?=
 =?us-ascii?Q?6KgOQvMpIxtASzZn5zOoVRX3WI9y7uxH8GvPBtxeXiNzNRbDrmgliCZYl1sc?=
 =?us-ascii?Q?TEPTmLcJ+N1H91kDszmpmf3SncBOAmpXDGLJjfxl9kjjIaQVN+kyGM4zQ1Ho?=
 =?us-ascii?Q?A2FWhzZ1Essk6XklovkxnOFP03sRsHlzm1DIIdJI3u3obbRn4ivW77PE6/H2?=
 =?us-ascii?Q?xqg5aHZUkEW9jzDkYzLH0uIMBbhxn4sssCplGOueFrO/ovuNJI3tw0RluyWt?=
 =?us-ascii?Q?JolTGcCKO5o19UKGE2g6K/hjW6kzsi7jbbR3Nl+7MIaVA2U7ij7q0OLEPB8U?=
 =?us-ascii?Q?tCgaJsWqCcfrSdp7M2c8sqyHokQuSuA/jjRAcsGq5HuP+2gkFQYTDUGqcWDY?=
 =?us-ascii?Q?EceG9Ety9F90HLxAr8B7ROQUhsogKam4WfDgqJ1sM98Nqhf5aht0VGw92PbX?=
 =?us-ascii?Q?3y+HyCjE2rPdNWfOq+EPcm/CDBpAUnwtr1F6RIUDDRA85dEYWgV/KfpgC59u?=
 =?us-ascii?Q?e5R+bSBEZFZ7d/QMdB7/5Io/DqYuEuIPbgfinny9P2h9Z89Qzn4qybYY+Ftw?=
 =?us-ascii?Q?dVnBD0/zreHf4W+Uf5554w55KtoOP7lKfMANGKVpZZj8cXZh+JaYhuKmE7OI?=
 =?us-ascii?Q?5CLgBBm75Q4e1SPP1RajVIlv7rRTbtvUl9Ei3LaNTn+s3VsWtUWn1lZ/CF2c?=
 =?us-ascii?Q?T5752GnstUztMyZ8N2KdhIghgImkR3vZv7qUItTY8iRyIU3sUHl2RGx9cceo?=
 =?us-ascii?Q?G3lRI7jHWFTsRcQogyGLfBkLqeMbQTydnFPSCwh44MmXe/N5I82vjBvW+srg?=
 =?us-ascii?Q?g0Rna/nGJPclcp76c6iA+WmRIctxihZTRQihzbVXAtnweZ0tvnkqgZ6NwnYc?=
 =?us-ascii?Q?SzR/DMwd/oXavNiDu2789UOC4Hb2zLh9IoclNCJ9IOhf6W48MyDSNQHFKZ9w?=
 =?us-ascii?Q?cEvTVf3iFBBojrWxeOY9oYXqWDvErvtVRQzSyBsqlIUQCLrTlFP7FFBEer8e?=
 =?us-ascii?Q?0g6MIP2JcxnaTd1qcDW9baGFM5ynaD08tNKMJmvYS8gDXI+xy2ME5b4gl9Ml?=
 =?us-ascii?Q?xCfOUmBYfmF8/O5Stu7K/WlT7JlgHvXWVqoOjv4aYGH6wQWdiKrQ1/8L1D5S?=
 =?us-ascii?Q?imkp8H4VSGb0CJHOCuYYaRA387RtCfUmTSYodCQKka6GJOW/tkURUHr3eAY0?=
 =?us-ascii?Q?WoaLeqArW1ke/Y7tcwhlzDYz2OACZ8zLBma14r/WeIdBzNcb8Znb11gnOHjl?=
 =?us-ascii?Q?ojDvv7Q/633nD2XbcvyUCWPsu48AXdrXIXpLx9lq8DqgTeQUIVLDfcZx9JaZ?=
 =?us-ascii?Q?pu//+B+l0reBYdEJ4fI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034937c3-3c68-48a2-ca68-08db448933c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 06:00:27.2428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMpK80fRO2jo9MMFI9zagfbRApEbwRFHmNO945vJndfE1zmAQWDqPvyHzjrBYF9v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
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
Cc: "Li, Lyndon" <Lyndon.Li@amd.com>, "Li, Yunxiang
 \(Teddy\)" <Yunxiang.Li@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: lyndonli <Lyndon.Li@amd.com>=20
Sent: Monday, April 24, 2023 9:58 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>;=
 Feng, Kenneth <Kenneth.Feng@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Li, =
Yunxiang (Teddy) <Yunxiang.Li@amd.com>; Li, Lyndon <Lyndon.Li@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Fix mode2 reset for sienna cichlid

Before this change, sienna_cichlid_get_reset_handler will always return NUL=
L, although the module parameter reset_method is 3 when loading amdgpu driv=
er.

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/=
amd/amdgpu/sienna_cichlid.c
index 81a6d5b94987..8b8086d5c864 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -40,7 +40,7 @@ static bool sienna_cichlid_is_mode2_default(struct amdgpu=
_reset_control *reset_c
 	    adev->pm.fw_version >=3D 0x3a5500 && !amdgpu_sriov_vf(adev))
 		return true;
 #endif
-	return false;
+	return amdgpu_reset_method =3D=3D AMD_RESET_METHOD_MODE2;
 }
=20
 static struct amdgpu_reset_handler *
--
2.34.1
