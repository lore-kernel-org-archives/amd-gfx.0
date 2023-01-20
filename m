Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A81C38142
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jan 2023 01:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0FF810E9FE;
	Fri, 20 Jan 2023 01:14:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE15B10E9FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 01:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6w6xOtH09tqc/rgEwfedXkx5Fpj2WTr8Q24K9jQ+A32cocjpBDu7r4w5qTZrV1Nzjy+xZyilyQ3SsIZWoN1120F9upDGyMj/hb/Y1Tx/BybLOXv1o9JgpsVJs5HqR3P2WyRxc3WKP3osPzwfAvWYlRU4yx6kx0sCaTs1IxQZ+9sHd/GrckX9yW52U05NmNZUcY6uiXemWi/3VX+V2SH0uloH22NKhZHeSBi2yMyULNF44AzRncAYc6ktGSy4SWWTTe0Uen3Qc3LaaRtVeM8AmBI7kAOHDRPMXjkeb5qM/fZXsPs5fDX2npS/Dr708DSPbi9M7Ddl6h745PREuiVWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gz1PbJQiZGdj+CepfMAcgASkVGzfPwgCIVCVJcjNz1o=;
 b=HDkh4iJP3/snVEOlPomwcdldvmehgfRdn8kPf2BOqtSBBezd5W+OSYE7ndYPvQ22M+4zRgZnmF3KLPx1KcOpsAUtSy2VR0gTm3pLm+bHLsyThC/aoUJGzOhzBC3pcaTB1ZgwrWUF2827A3Ko0sKH14iIiSKxN+1jg3+WwVrzQk5oKM+HXQGfder1j323GttswxBrkMzsB3VgsPyg9QTpyuPFTCTcwu1cPZuRYNBfADkWRhBMJusd4BO7ZftiYwI00wIp4vtExyL0dukZgajBQhyrAbeUuuILhXyv5kKe5IMpfqcPj/uvGGz3l0qrIZk0o976Q7ZW8CqtziBkicD9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz1PbJQiZGdj+CepfMAcgASkVGzfPwgCIVCVJcjNz1o=;
 b=UjzG25e1JO3DeTUinQNstzTj8aMmE6TWkNLP9jTeE0tOLuJX9BmUDiON1RiXh5gDbUqiZLLO7oGbrRkYcWjMqJ/QvVAljUX7ZFdBmgNyO/sJHeI+M3d/edE7jcCvZrsRaGX2ktaTwnYWV0bUHSoUZQDDFuaYrr2mdprDVfv21OU=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Fri, 20 Jan
 2023 01:14:29 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::12e2:2ad2:8167:b84b]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::12e2:2ad2:8167:b84b%3]) with mapi id 15.20.5986.023; Fri, 20 Jan 2023
 01:14:29 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove unconditional trap enable on add gfx11
 queues
Thread-Topic: [PATCH] drm/amdgpu: remove unconditional trap enable on add
 gfx11 queues
Thread-Index: AQHZLGhjAXmoYOFjnk6OYEgraSEhHK6mgAEw
Date: Fri, 20 Jan 2023 01:14:28 +0000
Message-ID: <DM6PR12MB30677D531AF2DF4EF1C8DB2D8AC59@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20230120004356.3872152-1-jonathan.kim@amd.com>
In-Reply-To: <20230120004356.3872152-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-20T01:14:24Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=593e1dd6-619f-46bc-9dde-39822857103c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-20T01:14:25Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d84ba5b7-b92f-4bf7-bf43-613d3e021d39
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3067:EE_|MW4PR12MB7014:EE_
x-ms-office365-filtering-correlation-id: cce0a458-46c3-4f26-b93e-08dafa83adcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KUZSvgbO+aHwZL8i2xfv1/cNPvRk816fMxBbtUJMefK2kkrofPhhAsleq4O2YBdpDxLnzlwSghW6lC91/8neXEDuNQTAhP/vWV/CEbnU0guqe/zfNyFrhn6wfUKfyfApka39NOyKGQjy3JGjE/owSOeb6VD1/D9OcoL0l5w5H5Klk/3Czk0Kr0SjWoh1zN5ew+i/bkW9EUqUDR09SuSxmgr3nv43MoyK+Iu6xJTyG/1+pqoL+PhKnBH70xt54+Cex8ZcAWHZNbP/pSXk866hGaOaNyiM7Ghddao8o2dLlmctUTgDvxue8PKMbjDVOJduOpslnjO6aivw8uXDHSth9UAyOqXiP4/uwBxFEiO8+VVT9mj5+uLkspSXW3i/r2yaYKUn6pIZh4fof4HXqokmtd7p4TxHCLrxJ4d3F09/sDg4skW7q+pCzqNC78Y4RuqVeWt4zhDfnfa2piusdNujshoNMTNNvcHXRpuaM4vU72XJQKcGn1vHDYvmc2B/9UAGXNGHRhe1Q5l8c0RgsmrsAk7DHQlUt6lrMuGZhTAyZya4zpkUtVwG/6nTwiUhEWflfB+8YiM60DW1326q62xrYktg4hGANlsvlz8xGQE522JQxgB5x/GwocPcPV4ZHqRL1HkprwqqqN6aBeqTXs2qLfoj+KYPWtvs3sydWAP3yym8hngslGIz37nx5Dn8AE8T8G3gG0EBe4xQByVoKkyrvw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(33656002)(76116006)(41300700001)(66476007)(66446008)(66946007)(64756008)(4326008)(8676002)(66556008)(110136005)(316002)(86362001)(38070700005)(83380400001)(8936002)(122000001)(52536014)(38100700002)(55016003)(5660300002)(71200400001)(2906002)(9686003)(7696005)(53546011)(478600001)(6506007)(26005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RJL0Y8S/rIDQk1dQ+dbr74+8G4xvpzR8xAIjKEzmK+P1UJniqfsFDL825MKG?=
 =?us-ascii?Q?KKoMSZh8vHNybAWJI8uM3DfPek1YlKrP5vEzOQLnUnHv/eb1WSRETfE/nJ0c?=
 =?us-ascii?Q?wL/+EorC3id2OJ9Pp20UH3zDTK8UtQjktAyjUpu3vz5X0siY+Q1ByQrAifFR?=
 =?us-ascii?Q?d+fg8FppcB4avVVWAxB0PQybDhRuMOvgOav6sTc6bJsVX7eIMIrB6hfkAagD?=
 =?us-ascii?Q?/dEnPE3EikqI6sjD1FMsSGVmNkM5HrrYA+6IZ6rZJAQ8coDtUFSBE6rJTG7g?=
 =?us-ascii?Q?lmYSFGjQ9VRtCOvgrHVozrnL7jsbDUBweKLHSE1LeebIM7tlc8jnRrN0BMSu?=
 =?us-ascii?Q?F5YvrkqKilKJ49clHEf54tpjgV5vsk6eq7Nwn56MrC1SJSuha5+F6a12Lusq?=
 =?us-ascii?Q?wVrUIAJAIzA0OuXuHlkridHbSp3cSoFgpb44TXuizRdzxJxEzvEzvC3tx7MR?=
 =?us-ascii?Q?KkQMuCguVHIBYtY9+GeytJBEpCE42TOueDsYb/vhVl8n9jsBXH3VuoS2twdo?=
 =?us-ascii?Q?/iQAG+tONrlXoZ7TKJSHyApDxgVEDs2H3bdn3YB2o5hHq7k7+bure+8rWE5J?=
 =?us-ascii?Q?UaOGTr2kTWTRrac0FAH0ODwrzaZdsFfTRBHo8wJJ/0brDgVGvsbefMgQlrzi?=
 =?us-ascii?Q?MLxPxMmmOLoFuZbVSCirCHttKNMZSi34RYrS6xepA9vNwRR86mA/hMacGNFa?=
 =?us-ascii?Q?Evv4vt0T885qZdbKs/P1ye8RdM2ICBE7dRe9TmyMravuCNNTsiXU8VkRrg/T?=
 =?us-ascii?Q?1c4FdiV4OeqnDaRivHPNnTtn29jrng3jQiSKRlBrVjW1XgTTiaZWFedTaXJn?=
 =?us-ascii?Q?XOWJrJNiw7FDVJqiHOKuagyDFHX1F1wE49ugGLfS4efnN2OlTXFk9DQnexaC?=
 =?us-ascii?Q?eyHmLV2w+5EMR70C2RWrkTwkm2YTWvR7M38GVMBOkxZWxz0pQL1DNWbzyEkJ?=
 =?us-ascii?Q?//H1IoDGZThikmqognHBEmfIP5DgK99xPCrkCRhWjDAMmqJofs+73Dx65b6P?=
 =?us-ascii?Q?0kg5pNACaWwhLnX/Ib9DUby99eVTNeu12hkDbZ8jlEzpyqlk9tYCXYb1qD32?=
 =?us-ascii?Q?VLAlZ9OSs3ketheE/w32jBxoIcAQuiKRb54hDRiQC8/7nJbg3dCLaRyUbEQG?=
 =?us-ascii?Q?dIW3AwIRYwbO47FMzT+X653n4oGpxpGzHb+rg4qfKngMW+CBkTE0szUxqkoc?=
 =?us-ascii?Q?6pB3+PxFMmoJNISo9SYnBmaRuCqI8yY2DnjpeZrO00W6OiKxl7M50pgPUv7H?=
 =?us-ascii?Q?fyVi2jT4h7opd+Kmwd6eubPSZJviy7lYwVFc+9t7RzPpT/yawd2Liz6MEeDv?=
 =?us-ascii?Q?Ynh5QqgEz2JFzTIgddZkVaor8MiOkRfxJSBkmNxNZQK+khZSKKt8ixNJvSvf?=
 =?us-ascii?Q?m0JlOUxcguB7cKecICDVLpxKw5MrMc+0WiCYbwzOCwFbstSieY8MjSCG3JIC?=
 =?us-ascii?Q?hX4o9wDNMaMRFck+MrpKkRHvF7qAAaS9vG2DvEEgYuh/pdr6mb9tl/wWnHk1?=
 =?us-ascii?Q?oadWY611/d+kgkH4UI32wsaeAS5vjkwInJWYsWYzVaBM4JJFSINJsThY/q3J?=
 =?us-ascii?Q?jIdqIzJVypBL1gxsPeo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce0a458-46c3-4f26-b93e-08dafa83adcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 01:14:28.9634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nxWjC2/h3y+ocEh4t9e01JvVzjJBngg8wxQbMeu6nyicjNp/cr0bqlcwY266jwKBhGYZEyOrrAt+Smj7ZRU1RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Graham Sider <Graham.Sider@amd.com>

-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com>=20
Sent: Thursday, January 19, 2023 7:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Sider, Graham <Graham.Sider@amd.com>; Kuehling, Felix <Felix.Kuehling@a=
md.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Sider, Graham <Graham.Sider@=
amd.com>
Subject: [PATCH] drm/amdgpu: remove unconditional trap enable on add gfx11 =
queues

Rebase of driver has incorrect unconditional trap enablement for GFX11 when=
 adding mes queues.

Reported-by: Graham Sider <graham.sider@amd.com>
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index bfa305079bfc..00e64838bb8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -190,19 +190,18 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *=
mes,
 	mes_add_queue_pkt.queue_type =3D
 		convert_to_mes_queue_type(input->queue_type);
 	mes_add_queue_pkt.paging =3D input->paging;
 	mes_add_queue_pkt.vm_context_cntl =3D vm_cntx_cntl;
 	mes_add_queue_pkt.gws_base =3D input->gws_base;
 	mes_add_queue_pkt.gws_size =3D input->gws_size;
 	mes_add_queue_pkt.trap_handler_addr =3D input->tba_addr;
 	mes_add_queue_pkt.tma_addr =3D input->tma_addr;
 	mes_add_queue_pkt.is_kfd_process =3D input->is_kfd_process;
-	mes_add_queue_pkt.trap_en =3D 1;
=20
 	/* For KFD, gds_size is re-used for queue size (needed in MES for AQL que=
ues) */
 	mes_add_queue_pkt.is_aql_queue =3D input->is_aql_queue;
 	mes_add_queue_pkt.gds_size =3D input->queue_size;
=20
 	if (!(((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 4) &&
 		  (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(11, 0, 0)) &&
 		  (adev->ip_versions[GC_HWIP][0] <=3D IP_VERSION(11, 0, 3))))
 		mes_add_queue_pkt.trap_en =3D 1;
--
2.25.1
