Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BD7C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 06:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C5FE61CA2
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 06:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5FE61CA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BDAE6E110;
	Wed, 30 Jun 2021 06:00:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BA646E110
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 06:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkcaJcjomrCsT6hc2oxFk3FkB+1H6fbrAiphVOcFulltsyS50tTjDDBNRZx6OI0us3pMwSq9kQT1eiRwswRNzyQbKrP5uA52o3tKHWG1BIC6dRRffcJ/t6oXcnMs4pRsM4fPQC6YmpPsbigCasPLEtQLu1/0mhdoO1r40ACKBJiy4T5gCrD21Spr4LBvEW8J802XZwzm0bVsvvqHaUkhifPOHdgRa7ScfL9p3FcyRxlhW2xKx31UxSlSCSmWBv8HCwHuhhYQFr7t0d5fS512t++qeNpoXWr9TVwTNnl8fZ4h1CUAKbNRXV4kspIS4oKkvTpNCwQug2CTO3VQUfTEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAbK+I3jk+ninjfoGO/CIPdFqQXu0H7ATkvOsTdMx6U=;
 b=ESmyyQOMTsSked8nC3ld/Wew+KCbyLMKtA/mzyk+7m7942uG1RsdLXamQ69uuAiun2SyYAEYgmQfJBxrP6ijV9QvFA5onwlvSxqYWfYphb9zAJ+4c56dRG8EBgC/c3514szeDo+pzKn5m4o7+17LqSUekc/h3+0Ss3LR76q+p/0UWboVd13ddTjObnVTiVbyWthLvEtgC3Eo2WOVmrA/n7BwbiKRXPsdjMEiPhslwZ/fphDgw1MQQUxqygg3BJgcnbps713857QxatEaB/8bJ/h+KbSvjaklqPEN4WGzY3QgOoByDh74Sc69uNiOy5RUf71z524xFwuQAOOhfgKTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAbK+I3jk+ninjfoGO/CIPdFqQXu0H7ATkvOsTdMx6U=;
 b=eXuZXA/RjGrF4AA1f9POSbrJhOUk0UPWVlJBDyDCQWsqSM3eAqX7DEMs3aF1x0ost6WL1jpZsrVW/DpNOyQuLTt0ziIdjVnnvhy1MVjzt4wBoop/cznNAWBQ5oj8kcx6tQt4x9/u9CTQHYvSuYtDwNy75VqoKoAqpJWQZcYEdsY=
Received: from CO6PR12MB5412.namprd12.prod.outlook.com (2603:10b6:5:35e::15)
 by CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 30 Jun
 2021 06:00:04 +0000
Received: from CO6PR12MB5412.namprd12.prod.outlook.com
 ([fe80::4858:55fb:a5d0:d3ad]) by CO6PR12MB5412.namprd12.prod.outlook.com
 ([fe80::4858:55fb:a5d0:d3ad%8]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 06:00:04 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Make noretry the default on yellow carp
Thread-Topic: [PATCH] drm/amdgpu: Make noretry the default on yellow carp
Thread-Index: AQHXbXTT4vUnJST2Xk6o3OniNZLLb6ssDxqQ
Date: Wed, 30 Jun 2021 06:00:04 +0000
Message-ID: <CO6PR12MB5412E41ED9EBC255E3DB7E35EC019@CO6PR12MB5412.namprd12.prod.outlook.com>
References: <20210630055718.3133-1-aaron.liu@amd.com>
In-Reply-To: <20210630055718.3133-1-aaron.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-30T06:00:02Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=589df76a-38bb-4058-a9f0-4d33aad9b60e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd1cd299-e510-4115-bd02-08d93b8c4e70
x-ms-traffictypediagnostic: CO6PR12MB5489:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB548986AA484646462B023CFEEC019@CO6PR12MB5489.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UNP3lOXutNBwGk9kPYy4Ff78ec9ihII79oI4YjpsNITx41qJVaxcWxI1njQ+BSlzmB+If5cIOI7cUQmSSkJxbrzQTp7juQQhO1xjQ02Pro9vYPvRlKN9jalIqEZEhcEUvdCS9OBmk+uCItx2zYRah5LZEa8E61fHPlLoME6bUXO0ESmHjnS8kkB93I8/Fh7G+KWBWLUGZJySJY2HTASH1b4XGH+PaYPvcBaVTvWl1xdcXQbFLzBdMrCqAYcD8YHyvNJcGSpT9MioJY1vhGkdJ+aZQc68V+1v7Hr2mpWmgpwJ688XO6PtzMA+g+r+1wTIDCl52chMv1Y6k1+ftc6oiucs3e2f7wd5uyZJH7gYfUloYea4vCIDAkq4tkmJkOgLk76wpx2uzb9nty1El+Q2MfhWAZ01QW+WGJtrKPmWCVldhwX95hQss3vk2VMi/M+Pp/o9DynkEvfqLpByOkSN2PkFGUhpM82HIJTN8MaBERaQAvOXRQ0KD5IPkH1GMFvKnN/ungTo0IiXjx9IPKhEl36H6QuAljEN2zHyWokGM7V87uafLRqLR6ziv/0Jv2JihMPtJezfGOyee/tCSevcFO/TYJLvy8gCGcV6ghqLBLjx/x7E1sSS9MRqytAzdg6Eat4zQE3HIdMXKwCUDFMaMw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(7696005)(33656002)(8676002)(6506007)(53546011)(316002)(54906003)(26005)(186003)(55016002)(9686003)(110136005)(8936002)(478600001)(4326008)(38100700002)(2906002)(86362001)(71200400001)(66446008)(66946007)(64756008)(122000001)(66556008)(5660300002)(83380400001)(76116006)(66476007)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ptqz59lxHnZ346W8tTHPPyFG3kwm+sroVURP9TkxahIfOLaMUWl2io0cDYFY?=
 =?us-ascii?Q?xacuR70PAu9lJ1HgSGa+lxf/P4JL68ULhPkWqp1Y/I/XOL7lWY1uco4/QplA?=
 =?us-ascii?Q?Nx/8B5aLiAfMYDC7RnCayXeeW+h5dGEQEA6IIBALpyMGuWDUVZqcMaC5fFYH?=
 =?us-ascii?Q?nUIdxn9V2jSjaQoWL4t40FVtGBrc5Re3sgY3sbGr4hLdrXJfo4APzkETm16F?=
 =?us-ascii?Q?FTmNcrQgmCouYynUCW6TFSgCKX7SCIuOKA3Mgl25CbaBBOZ/1UsdLq3p73o+?=
 =?us-ascii?Q?K+anIMTqTn+cS+K8ECgAxmAx3MF6g5QrhnMg+Qp+CF9Dxrmbyt6N9di/Rqj8?=
 =?us-ascii?Q?bkDwOZogdFXFdl6sEv4DjXB6sI+3NOb7Rgu1oDlx9akuz2EDwB+bNT6RRzSc?=
 =?us-ascii?Q?7MHTv20f1c5cfvmyVlNfE98QR6644WxEQQQR57Q4xaAZ4Fp4H1mVqRGMcZkf?=
 =?us-ascii?Q?JqC87CTSFtv5+CCzSWf98cN+dfA2UOzxwcHLP15XGmWagxF09SqmQBamkU93?=
 =?us-ascii?Q?pH3XZ8W8K3z19BzDvWZp5njnUzkPgraAZWjGAI2UpyOodSJJN9NHYaNvS+hA?=
 =?us-ascii?Q?XPiz7AkBrxawYHjBFsaTaoFoSmAbvxQ/cHWTm3UoYNVXqAbxj9FvdDR+KKmF?=
 =?us-ascii?Q?lHys0FRgndWR9boLQgjy9dioairWHvPOZzQ+TnCEAPqWFikADoiMCTxjelLt?=
 =?us-ascii?Q?ztEwR0irfKmaRF1w/D2V0v1rnXK80/YeqehAiSchyYJERXRsGjQmY4fWEI14?=
 =?us-ascii?Q?rtIcywG/7ZDIGH0ppyoj7eWlXetez5MBObuN3nc/MUAMbNjT04omICf+K4EP?=
 =?us-ascii?Q?J1Q9H6cRD2Jnawo5eYBn3wSd+nTcFznJvh95ffbyR81Rw8kFc9jA9myc5KvL?=
 =?us-ascii?Q?7DbDQzQplkrDfh8sJdpiVaOQO3KP4Rt2ehlFdpU9jhBB14urUOvUmlYzLXl5?=
 =?us-ascii?Q?ZjFfAAvClXOeAxX1rwzFPJF2XwWRMt7cKmxNcIvLuID1ex5M+WA+iezP+zVw?=
 =?us-ascii?Q?I6HyEhCIeD76TGfNBo+Ftf0fmOUKPv0kfHnSyrxkdX9f2W97AwB30qYtaYI/?=
 =?us-ascii?Q?rCjXVzI9uvkuhkZp2Yh06C0vL6yeSoetM54tc2hQvATPRBEtOtK4faKJj1b0?=
 =?us-ascii?Q?japp3bBYJ1lo+2PmnUxWmZGf4GYF6OJ4Omt8sZV+QRHFYestX1xRhuCXpoyp?=
 =?us-ascii?Q?Z/k4aHj96QO3G/rvEbABP6V39jIdSq9uuxQmw2Jv91TafLAYCCxV8bUJccvH?=
 =?us-ascii?Q?9mV1n+hIChEKkGkJkusxl06vQgAvOs2vuvJuQkqF3IKEUYMJofHlgmJzWSps?=
 =?us-ascii?Q?actV/ubknJii8dlps8//lfKI?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1cd299-e510-4115-bd02-08d93b8c4e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 06:00:04.5992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sS6y1lSCe+gPlFkq8vCghNWERkeOpNSgft84DEzohyAxYX0amkxtgkfrQKNNyXdfvGmNl5tCffczloQYqOucOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5489
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Gong, Curry" <Curry.Gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Liu, Aaron <Aaron.Liu@amd.com> 
Sent: Wednesday, June 30, 2021 1:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Gong, Curry <Curry.Gong@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: Make noretry the default on yellow carp

From: chen gong <curry.gong@amd.com>

Performing kfd page fault tests on the yellow carp platform will fail.

From the scan data after the failure, it can be found that a nack=0x1(retry fault) is returned. but we did not enable the interrupts for retry faults in the code.

So we need to set noretry = 1 like the above ASICs.

Signed-off-by: chen gong <curry.gong@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 1525d957e114..d4e9704dec62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -591,6 +591,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 	case CHIP_ARCTURUS:
 	case CHIP_ALDEBARAN:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		/*
 		 * noretry = 0 will cause kfd page fault tests fail
 		 * for some ASICs, so set default to 1 for these ASICs.
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
