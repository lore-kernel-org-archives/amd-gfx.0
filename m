Return-Path: <SRS0=CFUU=N4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79058C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Sep 2021 00:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F28360EFD
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Sep 2021 00:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F28360EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD7C089362;
	Mon,  6 Sep 2021 00:11:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC36989362
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Sep 2021 00:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeQHE1HDwNEUYbtD5hb1SMru0EGOKcCM9CwzSj5QocjP61WwcNrniBRTkGh9JeKBJb4HMubUY4pC7H/XYiMTiN52H2Np2xDYWG95FDbNxFKNUv2HhUo2nZ719F2Et1QvJlt7mtM4ocY4ZnLggruYVxSKotKQq18/DY+HAJF0OAzRN/TlO4dreUneyJjf8DOZHWQYXir9Y3qcTak4IyMtCNaRJVZRNcJIG9JcsTQmtqQ188gp5cmkuxQluIm0vnW9jxbAim1U6O77r+6D8kHEA6yB/LqxXL2rcRIxgip82mE9BPVHagpFc49AF5eeIifrN9VpWrzl5+k4rdILwFC6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=N30Til6lYnqme363WDF251BwTkOUv461azPTOz2jQfY=;
 b=nnc4Lk+ttnmxP0AqEosaT/8nRXWcmcBpL3TDsu57zR1fJiNb+rHuViMVVFuZqOpp2ocT7sDWL88rujgV6E5/u6yb8y9CYwCBZd2I583QVXOBefrWfegELN5cIts2sC26LnrOhpZsMPJPHACRY/keq1MPY3zj3t/f8zorSG0VFi/2tCW5YlGV6JFtOYaFr/m2pzKArklCZc59PcriWAqmtVrZvz6O583vgP080C34diVQU/WiSh35kn5zcVkAUEEePVztQHUz5VWD/d2IVMfh7WquFWi8XAJsJvLyWs00Eaq5N7TTCoaez3c0NVpfc8h+fyutmuWg7gstflFNc1VAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N30Til6lYnqme363WDF251BwTkOUv461azPTOz2jQfY=;
 b=JdkUzd9qhz3BqEbcF6Ug4MIaCp7khRMZFoa8xDSbbGOFtDv34iyB2NlwnF1zpVVvSzoV61MgvqB9KN51ckFpvenRGH6l5GsN7k2VIaXVK+RR69Z5GarnMvmdIeYGrR3FSsdZsxfsgIMnuadt2PLTbP7xnZIME0wKjPHWygx6zCI=
Received: from BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Mon, 6 Sep
 2021 00:11:50 +0000
Received: from BN9PR12MB5244.namprd12.prod.outlook.com
 ([fe80::3928:7b60:f7a4:bc47]) by BN9PR12MB5244.namprd12.prod.outlook.com
 ([fe80::3928:7b60:f7a4:bc47%6]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 00:11:49 +0000
From: "Gui, Jack" <Jack.Gui@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix the issue of uploading powerplay table
Thread-Topic: [PATCH] drm/amd/pm: fix the issue of uploading powerplay table
Thread-Index: AQHXorHDufi7Y4dzE02M0SVA2zFruKuWIYzQ
Date: Mon, 6 Sep 2021 00:11:49 +0000
Message-ID: <BN9PR12MB5244FC71CC53001AE84688AA8BD29@BN9PR12MB5244.namprd12.prod.outlook.com>
References: <20210905235705.3583-1-kenneth.feng@amd.com>
In-Reply-To: <20210905235705.3583-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-06T00:11:45Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=53e293f1-923e-41a8-a9cb-82cc56a45ab9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efedabb5-2a19-4949-a5be-08d970caec48
x-ms-traffictypediagnostic: BN9PR12MB5131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5131B652B2D37C5EAFB276778BD29@BN9PR12MB5131.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:519;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7LepcX9ZFqZaAhmGaH4Owq0LKuWR8OmAvzEcCOj9VzVOvEkwqpfojgqnH4Hq9ziYvy1/Q/QOiLTRF+j7jtgKkgh5lJFC9jF+MpgITLahcQBjLLDkfwnYHIaPIPJOxHGBAZ9kIyRbg2d9Am1BRKW0a8hCfzmnpu1fjXZ7uSF6KyANT0UcmXovfXFWvod3Ug52nMG3kGXBK1ptYGxeKfT0/uw2VVTjHRlg+pDHrZuaem1jT78iZEIgrC+vaAsAtcVCCoO3/MFS8n8bI99ynqf8krm3jtRw8OG/236F7hTeg7k+bmLen48XKdCHF4BeTUpiZZ47tI4kYO+/4+Qq7I/nWtikp+FeTSPiChFGP5O5gf6YZsb5oNCQc3HOJW3ORLoxABJ6nOnUS9OVnSbBSVlfU93I6UwOuz3lYixk6xmxJvQGT3VnyoRTWYMPjkjdl7CO80iwa9RoUg22rO3lCUyaffr1ApM2tTLUgwWfhaO72/iFIONSk3qN2A0dx3+k0HznBpV0X3MNiFjZ/0i3gfhs/NLg0R3+HZ+VdwcZua3emxX7lFyq0qTpUXPOxSdpLdriJ3shDTcno/8X+ahty/Uk70R5xINFrMdJtcbe8Ez8L9O62sSbpm69qn6o9zgyYSbJWNRGY/CLjdGQws/0W8q1DZmA8YuOuOYLubUjicNNJ0unxuwE6fyrR1sVFDXxUbhjICqCYbqEJ3cwuyzbzRMWWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5244.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(38100700002)(4326008)(186003)(83380400001)(52536014)(26005)(55016002)(5660300002)(33656002)(9686003)(71200400001)(38070700005)(8676002)(53546011)(6506007)(7696005)(66446008)(66556008)(66476007)(64756008)(76116006)(110136005)(66946007)(8936002)(2906002)(86362001)(316002)(122000001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K6/Bm2lwT7DNHGS+GCp3zorU0yap3A6mCuLaCsOi19PMWNlKGbnjCEV5Xjhd?=
 =?us-ascii?Q?wniQ2QJCYSv3tjkU42Yg0IPCwSqSCyXtavKYG5Q1trhkdH910Io7G7LuHyCg?=
 =?us-ascii?Q?DetTIDLlNdvtlcZ0pHXWiP3fSJdHvTkn6kL5hNFRGczCbdZX6CyeyGx2/uq9?=
 =?us-ascii?Q?yKdTb6bn31ZGsJyQof0329O6zhqFLPgg6qwUNEIYQuyIsfc9szsbd8Aw6jpV?=
 =?us-ascii?Q?AQZ+GMECO6sAMTzL2m0FrSDRi6Xk5a3+rGTgAkwBmGxQ+eFJv9HzIoagzzOl?=
 =?us-ascii?Q?oLDxL+FRy6pchL38Ck34wsZPTQ6nCa5spifymjrxObz0OBUN6dZkxlLyUsHZ?=
 =?us-ascii?Q?2PwIboJNbzAUpyvyzkM9Cf/Fk+LWUW1xlwBSEpHBUkC+G9S5jDwZAh106d3F?=
 =?us-ascii?Q?TPXOxAV5jgv+2l0XukF0GejVAKyrRK+GFd7QT2TdV27oA8DDOPPR6jxW5WD3?=
 =?us-ascii?Q?7NsDXgVipGhfRSycnLnYKZjIRpQSqE2uclK5qVTE2FQzYp1aG3E8WS355a74?=
 =?us-ascii?Q?vgZWcqvhRVHh+XhAawUkefV1+ApGf7WxFVKZ7zOXckDlAmGhEgSa7RFMS5wg?=
 =?us-ascii?Q?WhF3MXklE4RFSb+0KhA6docSK+cnyDzabiJJPz0gNO0xfc5CsPyQtJ4RsuAS?=
 =?us-ascii?Q?IoRjGK3HH7mEyv9CnFHyNetNRjhjJNzAKbZ2C+mntemltVz4UknIffjX5rVT?=
 =?us-ascii?Q?DyhrmaU//Uq6y9UvYxZNERCFaxkdHljlHNQAI7pu5G/I/RQ7zGSschJpFJcz?=
 =?us-ascii?Q?gTSyJhKYX2WURGxXVfj2xibBRtmKGaLB3wfcltTKG2+J6bStMP4q6xQX9cOU?=
 =?us-ascii?Q?LuXtyibwlZ9yzN0Q9vMjdJwy/ggyhCvlX049SBaZY5ekHiIwGYnQ2iZGM9Pu?=
 =?us-ascii?Q?UMT98Lux9+SvmCgZofw4NwgeiL+8GTcDyrhBJKbdsBugn6rTMTMbBnuh8XCQ?=
 =?us-ascii?Q?X9lpTLGKq9Uw/DZqsZHKAsRjLCIQ4cnbRbj8ijxRFxtIOcMEEfTgT5xjKtnB?=
 =?us-ascii?Q?sy+D/zY441F4qlmMj0//E9Xg+wQayVtb0iYdU7Nh7NqQF3N5CCFa/xNQ3Z57?=
 =?us-ascii?Q?N7VrRTxPJZjjzx/bRMQAdVixZuj4VNcivGdBAGkdiqtQeNi/RbhDgjzNVGeo?=
 =?us-ascii?Q?WPkRcofKja+woRZv7NVgNNKSgSn6Lfotrlol00hC1MB5dalMfwEQMC7J97lo?=
 =?us-ascii?Q?ClHBExPfzZAL1fUOFHAPSRAh/4VSuvuJrtt725tvqLwhqSAFey8bPPwJqqhi?=
 =?us-ascii?Q?akCH/ibDTpfpKg2o1t66504cPSLZHrTn0/QIc1aUcjbkHSbq3RXbun5Gp0i9?=
 =?us-ascii?Q?70Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efedabb5-2a19-4949-a5be-08d970caec48
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2021 00:11:49.7045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZkBcwcw56z16hf7yWXH8pOEW8Yq3N4BWA8/BsjJMx4Mwfar3zKXswiVcknIuw5/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
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

[AMD Official Use Only]

Reviewed-by: Jack Gui < Jack.Gui@amd.com >

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Monday, September 6, 2021 7:57 AM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix the issue of uploading powerplay table

fix the issue of uploading powerplay table due to the dependancy of rlc.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 3ab1ce4d3419..04863a797115 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1404,7 +1404,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 */
 	if (smu->uploading_custom_pp_table &&
 	    (adev->asic_type >=3D CHIP_NAVI10) &&
-	    (adev->asic_type <=3D CHIP_DIMGREY_CAVEFISH))
+	    (adev->asic_type <=3D CHIP_BEIGE_GOBY))
 		return smu_disable_all_features_with_exception(smu,
 							       true,
 							       SMU_FEATURE_COUNT);
--=20
2.17.1
