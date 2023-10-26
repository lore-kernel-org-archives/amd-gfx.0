Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F55C25B67
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF2D110E7F6;
	Thu, 26 Oct 2023 14:33:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7622D10E7F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaLy9SUCVz8hgpQW57dtGOimFe17R1FNnHLpPKn3bzwV6RLaBv2PtfPxErQrqenMpOzs5gKM6FF1giEJuGWS5fTKERDi07qmpbFmSAlvCaTHlN2NZwWVsGHMfIlMndZmDJv/W/R72KE+6cHVnsibOl5DX6fxyumLBLW1RUzR9dozZlLIlZvVkYtezyUVKToHjNwxkhbUtnitQIdn/kJbYVtXzThUdZCmlbXkS9QtQpSADwRPpQi/LeMCVjoAj73xzPorSVbJ8q9WCTipGNX13euRIGAC0mtlzBoMEJFG1XXUZjZ4vNb4ophb8JycENy4oNCFOxiy8jMWVAV4rg8nSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldWBFiiMauVMkAYCEQVE0IDP4xwDdWrbjbnyda3515E=;
 b=RnplKtMdNr5UF4/6DTcs14J3wrTXgNl2xj4oGBFLsN1K1+Ynol4d+RcESWig5QxMAd40exCb3jrFG0OdwbaKsCZvNp1MO3o+6x8Nj50uQsHdZ7z6CqwKdiFyR/rJg51fXTKUV9WIg0pGTKan4N++NImBxjBxN1gEiBlYKdUrA1orqxsBhp/POf5E1Eg7/B1NaJAwnhNA1dhNWl5zv/0v+JE66mhVsZQ7+ilyIDqKCtyW3Ttdqh3BIPZg7P8Tf51GL1Pdj8XZ2YadiYlAgcEF5MlR+rmXvSpSAc9VUDCsXo4bI7NIuRC/kI+gP+NfUiPc3byHJMJu0bmsdWZmGaErag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldWBFiiMauVMkAYCEQVE0IDP4xwDdWrbjbnyda3515E=;
 b=OHMc+FdIzbWp+/g6lwAi5ShOcNFEmGj9GFH0Ae+oAEM/QEYk24B5eL8WJC4NH3nxlLvxWyMS3x/xxxKKOZ74EehG8WjQGv/LbFIhAW54TSJ2YYnWrBgB6Ye4QTyVizrffud/gEl+cyar74oy+1fHItfLNUw/TZo4K4W41T8k9N4=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 14:33:25 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.6907.030; Thu, 26 Oct 2023
 14:33:25 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/soc21: add mode2 asic reset for SMU IP v14.0.0
Thread-Topic: [PATCH] drm/amdgpu/soc21: add mode2 asic reset for SMU IP v14.0.0
Thread-Index: AQHaB/CaoDuB7bWECEmc/ef0/kWcTLBcIsMw
Date: Thu, 26 Oct 2023 14:33:25 +0000
Message-ID: <CY5PR12MB63697421474E55467612E878C1DDA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231026094104.2133426-1-jiadong.zhu@amd.com>
In-Reply-To: <20231026094104.2133426-1-jiadong.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a6fdc0c0-5684-4f53-aad8-8a5e89249b0b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-26T14:33:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|CH2PR12MB4104:EE_
x-ms-office365-filtering-correlation-id: 30639704-9c65-43f9-7d87-08dbd6308367
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E2d9rtvl2AkJ2jnMbbcBP8GTaL7COoCqx0XEpopqQ8VxKn02MtqDpNxtERl6zaDEhacqnKCBLoDq4N75fTC3SECdpVbuz4LglAxMGQTa8vek+9Pgc7xOvx/5cnvC/DUI9wOXgNoBhhPkJYOIrNwodk++RDkWNGzzQkU27mYUh/lfW3RNP3Cg4+TJCcKWJ6LZUnfijedu9XcMc2Qk77EH4APGBSOE+5+TEdTIAIAxf0qQsqHuYnkuuvQC7/VAmpfriXymXtsFiqiJFQr4AMPSak55wF19ceH7SQ12pE8LlPUdVLVqubGQPgb01I8Gxt/hBNFG7nC+OHqzBcjt6bdn9W2hH+VEeLzRBgCK8ike0asb4xOMO8e376WGBSFyUCBm3CnS7eDRg+RUxQ/xmnzPGlvq/4ePcC8xwEXxmo+LvmeMT5Z+Zzt3WQY3HuqJW8BmZt7Vs+X9dx4Hs8ZiJX/GQWFGPMSoBGAFdCPm/ouxQ76RjJkfR1XL4F1Wgbs/MThujjyS80K+29Uyo2CifuA3Mr2qQLkyl4wXoesad4l7/pCeOJzaJ8R13AsEKn8IAfYgAZ9iuLV7vICR1/38Qk9EySjYieR9wi8aCXjhLOxl4QiDg/IVXeJ1SxeLQa4CkEr+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(55016003)(83380400001)(71200400001)(5660300002)(7696005)(76116006)(86362001)(66476007)(66946007)(110136005)(41300700001)(66556008)(64756008)(478600001)(9686003)(6506007)(316002)(66446008)(33656002)(2906002)(122000001)(52536014)(4326008)(8676002)(38100700002)(53546011)(4744005)(26005)(8936002)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0E+Sc8a4n7A+mXA7Hfh44bHikYLLy45yQVvAWVbi9phVCgn90s3k2FJdgYQK?=
 =?us-ascii?Q?hf3kDytB5ALj+SDiY2zLkyZnRMwfyUwfKp5fIC093k06PWqoLZEEUAt1WTBm?=
 =?us-ascii?Q?P+iNEcvS02q9pGo9UFLDQUl421GurKtZ1zvVitgDe+jLxQD5ecUQhZ6uWpwR?=
 =?us-ascii?Q?idR/Vyy13obeOPIRIXsnHZ8M51xLJELzeoBpueRmr6DUHeRJlrFC5c1J3PQb?=
 =?us-ascii?Q?re6Up4kX4FI44gnVGfAznVHZc4KRDm3HJ45oYfJTXRfU4LWuCq/oGrBS5uZv?=
 =?us-ascii?Q?SihWz79ILX07elr9MxsifLcmoWkxvLMYOq9txw70fM5PVqTqJQQaaJJy4Ueu?=
 =?us-ascii?Q?W+Ut5yDTz9bCYJ76kkpj0Hv/WF+9SGItXXnBQA8OBpNAuyJ5P5uiK3xPpMYt?=
 =?us-ascii?Q?LZKCCGqM15E3jthOALUEi0f86AKRra6dVChQX+a8iM1NUHap+Tu2eVKxnmev?=
 =?us-ascii?Q?FMg/BQYZBF8HM6q9QwSdU2+4JCoI0HsoxjekJmGStak3244B5Ap0bEUILqcU?=
 =?us-ascii?Q?YTwvy6UTCTsCKHeNNsS1bCeE0JzOjrNtpzn8TEwkQRujw30FUglXv0m1o9SX?=
 =?us-ascii?Q?oQSLDXPtdgIX5u3wvItQtIbU3gl2FFn4zzqp7CCE5fhBUgCd9RiK22qt7cLQ?=
 =?us-ascii?Q?keYveoUjU7kpRLOkGaUp6q2pRrQ7qq26ZU3CLMWbr7JUBm2D5OmuxIVnhCnr?=
 =?us-ascii?Q?qMPg4csBENGUoFsove45qSE1AkDiM/yiVdWJCY1Y1kvtwgxrJ4dB4znV88TG?=
 =?us-ascii?Q?UW1rrcPWpnNxFPnvK5SelLGPzIEr1gU0D6NWerT4YGcq2DXQNUhEIZAI5ztd?=
 =?us-ascii?Q?lxDmEG6CmGMAI0mIdq1s5iiMkp9oxThEZVdm2FUXeNTXdAV1e8sBlDXkyUe5?=
 =?us-ascii?Q?XD45Xe1EfKWpEkR4XaRSgvmWUt0OJnCaDOtLOm3oX7lrFARv9E0O2tnx7i9+?=
 =?us-ascii?Q?6i1p3zmDJZnnmH9VnXdEINyrSdYoZfHC1vPuX7cG7IU3UR2hqiuDH9n1LAAz?=
 =?us-ascii?Q?78JGt+0R3UQlwbV2FU6+CR5LGKFUxdnLm7LlfAa7DDxPyJ5OwYR4d+dybB1U?=
 =?us-ascii?Q?bSGWD3+A7MeIQbnQKsvy8MK0xkCL0Q0fDtyD/IhKE1Y5eVs/r+i+djNOM+LX?=
 =?us-ascii?Q?RBsFswYw0QaKCaaWo4xtzIFCe/EsqFZjqALcNTgHEJKB8lPm4qC8e1DLfIJU?=
 =?us-ascii?Q?BpgDTnHTnblmhg8KcEl+twLoAkPuKwfhBUC6GKpOd3p+6sHhtvnz+4NJFXPT?=
 =?us-ascii?Q?eJoO9MH5kd9grFvHe7MeoYDGo0GERkRO8Ot6JSlNepdhvdAdLMHzGC+d3h07?=
 =?us-ascii?Q?dNF2s4bZ7axBzZD7M9273D8CPV1OGRSNi6wdee2DdKBFmy3l4JMS81Ro14k2?=
 =?us-ascii?Q?hbI3kvc0kD67AXFv8x9qKJ3zK/vnTSBdyA3afhjpfW1qU1lM88DdBoRiBgJt?=
 =?us-ascii?Q?l12MpcSI2P1TppV3rgTyKw7AqJeYWkW+PA0UyNwj96GBrHPEI7zPH9aizi5r?=
 =?us-ascii?Q?dW4rclqfRFZrmo3pxL4jor37HfuYQ5knrtVnSDrII5IoMl7sxD7OXXR6Sgbp?=
 =?us-ascii?Q?1eR/lR++V3+2s1HNBG8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30639704-9c65-43f9-7d87-08dbd6308367
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 14:33:25.3614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7YcmlgDzkDaFH+UWAySe7G8QPV0Ex7LeATwXryDGAP7bTm/3xH9APIlKsmmlqf5b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
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
Cc: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This patch is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of jiadong.=
zhu@amd.com
Sent: Thursday, October 26, 2023 5:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhu, Jiadong <Jiadong.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu/soc21: add mode2 asic reset for SMU IP v14.0.0

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Set the default reset method to mode2 for SMU IP v14.0.0

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 8c6cab641a1c..ebf99406e634 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -381,6 +381,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
                return AMD_RESET_METHOD_MODE1;
        case IP_VERSION(13, 0, 4):
        case IP_VERSION(13, 0, 11):
+       case IP_VERSION(14, 0, 0):
                return AMD_RESET_METHOD_MODE2;
        default:
                if (amdgpu_dpm_is_baco_supported(adev))
--
2.25.1

