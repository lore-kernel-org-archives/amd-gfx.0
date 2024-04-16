Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B281C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 06:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31716112A60;
	Tue, 16 Apr 2024 06:26:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="47CWJNp/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 691EB112A60
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 06:26:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwSLM0u06O3L+nak5WJfFwWIwYLcp/DSjgUJhvF5p+SDHlkUg6J1iP63Yo/ZiUGLtV9lc/cc/7GGUqovsYadIBcvqxJfZEMk1hCnEXzrX1ntWeeqdVLArQDyfIgAbbcLNmHmSHJFpFh5ME9D43qCDeJAtGG3O8GFHrA89/SJAw4e2FsNb5uMdWM+kXFRwprZqr6Cq5MtMciRQ2W/eQuo97gMYwYbk2yLx6Z1R0wWd6Hln9KxoLpMMqaz4cX48CNDb7wt0njFTplR/yNTT3Q6rMHOxrEWYuHdgqWHnE0aLQLHyxy3HKgPyGKfXRxedfLGISRW0Q/Q7muLrQhtskiGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GBvJ9Jcl3CeqVNnEUg8UIXvnDv73H+8IxXEA+VrnBs=;
 b=NyNR9r7/D9/VdT3hp1kPH8I49d+mJGb3v7sLCKQ8T7Dfr77sZ9EZn6qUolK4tWv3vdEAsz2MYipVNuJTp2dslWqH9ntBh7y1v+ZGmB8WET5styf1ZV8SQ5AbwodXXk96B+jcLrajru/ODe/+/8n2m47Aucmnt8KpDuQOM5JfnK3peTqJXdm+Tp92KMCPCsfhLcjixSg4qLqsb63HUczqk3oNzMT9mx9+AkIh88RxHFouhwMXIobMALJJ50e8RmZfxiV/1WgM1p9yXXk3IOzpCib2XLUqW3FCR0PFmnNHcIjZEZS9FlApfWeugAchR6bGOZqSO1Nuj1f0sv+QH0DQMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GBvJ9Jcl3CeqVNnEUg8UIXvnDv73H+8IxXEA+VrnBs=;
 b=47CWJNp/VeuNrXPmGk2uFJYSCi+ECq+u+UU422Tky4vjmyornghHmO85dQevpyAWd8wegYB0yz1mEdLIo0xV/0WG43ugTbE+h+K+wRLiCJ4B57WgYA3lbdAtICcwfcjxH8PtoKH3+Hoj0JqGhiY4i2hjjlC1k2ubXk9b+IjQ1IY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:26:16 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 06:26:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use driver mode reset for data poison
Thread-Topic: [PATCH] drm/amdgpu: Use driver mode reset for data poison
Thread-Index: AQHaj8WkpT0aAr/f7EeWJ5CbT0uHd7Fqbd2AgAAAg9A=
Date: Tue, 16 Apr 2024 06:26:16 +0000
Message-ID: <BN9PR12MB5257A0CCEE8D2D943276F7ACFC082@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240416061625.2557-1-Hawking.Zhang@amd.com>
 <DS0PR12MB7804392670933AF4F1AEDB6297082@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB7804392670933AF4F1AEDB6297082@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=cd8467a2-65be-4eec-a9b4-34611cedf248;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-16T06:24:07Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB6649:EE_
x-ms-office365-filtering-correlation-id: 05eab0b5-4688-44a3-6f88-08dc5dde1f14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YPOr4J8e0aeQb2S8BLm9ooVCwDjSC5BLNtHDd/mQivkcPgc1W8MhcjoNj1yOygYNRD209L4bR0w36t4yQL2OT+BbcKpUWIkNfomqFuPu7ZAiH1SF3tM+tESthQIdZVudZH0+qfXGdEg1GiKL1PuFKrekCh7sBfC8X6J5H7fA2cormpWmXALNGq5TqH6aYXiHWDSusBE9qJknYEFbV15VA8bgBvaGx1MQ8n8NkBi9U7fIJ+kP2TgP7l2xFQG5qFB/C4VPzcHSc6L66q9nFiPZt9yijEbtITDwn3bBDeN0eKVWfeai+/4RxzWclrPiW1qDY5FvloeXO8/eBq1Lgf1OfkJeV4Qphm/0y8cbTPznX+F8WOlvGtN8g4cXLuN2yzb6+zllBrHWqwRQCGYaKDJX6yW+Jg8AEeLUpzUICPyDl8xDfjPxiuEZTw5ItW8AIZhVyaLDjbdpfwWUSnuT59vwO/CaX1MYbyVhduC2CLRFEkt4/FU36okqSrCqjP7dY47YVmGGMV+eWmlCbQYmrevtsEnCPokSuw3GKiuutwsvskby0Kbt+/OTULtDY0rShJmNNDpBBLQJNfa8Ec/jcjRufhNtIH8UYCgDG/Hio7XfcoXLxqCfbLux/X0zafnlw1ATw33OE+XDitGVDqqSAiqZ5blFTknCtMcwdJqIR1Q7O9BqZC/iQ4YHLgMgW+8k6YerYnEEYJtb5LDANWhmg3tGBg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FhH5ooqc7E9GkId0qR0rw3PkY1fOhsk0yZMEQmdK12VTh/dKsIbNANKRrOq9?=
 =?us-ascii?Q?kowsfVHiQUMbhzCA/WwPVJR5WfKUTJ+uz7zWSF3JzfOfpglC16JpETsR3UIZ?=
 =?us-ascii?Q?H8J06aXbKqQP6NhRE6ghKexBI451veMsHRmNsVLRrQa+lyb8FFmhOXPoH1P9?=
 =?us-ascii?Q?eaLQz53lOJ43GrJ9KWWdhlLCFLLIIFYJdijAqODuvXc3DtUqaUPVI93HMazZ?=
 =?us-ascii?Q?HhsABnbQBSyXHSg+7AKzpFCmW3wDGxR/RsZ5EcISM1avpAaiheYnxHanTdN2?=
 =?us-ascii?Q?lBce2vYpzDf8LShZFvMn+3GC/I+Pyes0xKEjuV9SNb5D5ywCPnmHX7KnK20n?=
 =?us-ascii?Q?ARzYjYUo/0EPXzHBUUDHktRQ5H6u7H3ITw95zWCAsDLnDjIOvmDAo4Q50SPN?=
 =?us-ascii?Q?9yMrYu84dOGPDwqBBKoT+OPOw4/d8+s9SuqJxWMpem/MoJ6YNtoKEDszIx77?=
 =?us-ascii?Q?gyCgPP/+/ItTXKB2JiYImRY1A2Dn+f2JX6Ieli7RPbe7u1YbdsDVL7AkkV7Y?=
 =?us-ascii?Q?MAnjLBEswZcIxf7dHGXId1oKEWPvD0t3anOqQJ6imfIXJTMH9/dqXSCiThr3?=
 =?us-ascii?Q?2NhFjBwDcFZ4rjSYvvziYmvs/20eR9QhS4SInV918Vfqq4a1bX1Kxb1rUHQE?=
 =?us-ascii?Q?B3S1yfKrQwLNvxS1iofJnBdauzyPNrTHDN/xxtxTUffkYULtH+In0k5bl1zN?=
 =?us-ascii?Q?bXwrgHS5+K42M2ahRSxUZZqeXVroc6gdQGzKe+RIjTTmAVBg5i0Xwr3IBzj1?=
 =?us-ascii?Q?2h1Uqnr070Vucg3Wdsd3mPtpVz6jJqP3imABo+VdyazvoYlEXAp8tnibWjg5?=
 =?us-ascii?Q?c0sTDEaVsIp0EWO7H2MgAtJwvBhVy0KHYNs98ahng68VAt3fVrt9E+pmK2O4?=
 =?us-ascii?Q?jYuEfxjXQ02zuJTYPNnQK6VTMaGQP6GKX5z/Ewt5UH96qzNpKK4l5INPaBtv?=
 =?us-ascii?Q?LsCllMqzH1jRD9dOJglKtjRhJEVyiJD1X3oVQl0STjAggd3r26KzTWIJZuGg?=
 =?us-ascii?Q?H0jhhmwfdQKtz4znYVb4R7xqm752RtCzTJkrFlo6mdCK0iTVzwW5Mk4ea8hN?=
 =?us-ascii?Q?p6Q+cz5k0Xx4Qhc8ucWA7fU6T8U96EOpedpT9E7YW7pf9jJoCMmoE0zp+Iwk?=
 =?us-ascii?Q?ANh2k3yH9Zdd37M8gwKxqzjhCSvv0C5WGyy6M7nv6ceMFm5UfBSlFxDdSsuI?=
 =?us-ascii?Q?mPmcUcGJJzE6S10NhL+FXBqESX/8FRuXIa3jKVflA1DgY61nlap6GPZYa8dB?=
 =?us-ascii?Q?k2XjGi3bbv7GJ2en0CxQxVg/nD9q0c2K+t/KmfRMfMcr3koEWAL9+mZFviJi?=
 =?us-ascii?Q?ih7SgI3suOijhihzy9S5V8GeMrv0WqVq5ZMjshnjIWTmXhOlFcqi9FAKdwTi?=
 =?us-ascii?Q?/RBdjPMtHkwMs7rQyMj54x0a1jEaSh/3BedzfbkpZP/JF3RushzczEVwJ72e?=
 =?us-ascii?Q?La+xgZ2ny0tQ+24b4FX0M2sC2i0zLr9k3dan0Effh1VIVspPXlYnQC+Jr/h3?=
 =?us-ascii?Q?xr6z81uFWyUgpn35g4/vQqkaEmnj2AZLJ9zgtFk5WKWXt/WqDyzdFN6p0Z9l?=
 =?us-ascii?Q?ZA9GwRjb/xUZmxbJi1p+rpqaXuX5nfwM26g9QAXV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05eab0b5-4688-44a3-6f88-08dc5dde1f14
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 06:26:16.4884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4DpKVar6MMpuXSd5bEcgQaAcJMzguI7DKNk2hjRkbkyobDkPygMNvLAOlfzx8/10ZCu+D90b9o9XNCeE3BHrJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
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

[Public]

Yes, the same strategy

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, April 16, 2024 02:24
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; =
Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use driver mode reset for data poison

[Public]

Is this applicable for aldebaran also?

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking =
Zhang
Sent: Tuesday, April 16, 2024 11:46 AM
To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Use driver mode reset for data poison

mode-2 reset is the only reliable method that can get GC/SDMA back when poi=
son is consumed. mmhub requires
mode-1 reset.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 27 ++++++-------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index c368c70df3f4a..c3beb872adf8d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -144,7 +144,7 @@ static void event_interrupt_poison_consumption_v9(struc=
t kfd_node *dev,
                                uint16_t pasid, uint16_t client_id)  {
        enum amdgpu_ras_block block =3D 0;
-       int old_poison, ret =3D -EINVAL;
+       int old_poison;
        uint32_t reset =3D 0;
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);

@@ -163,17 +163,13 @@ static void event_interrupt_poison_consumption_v9(str=
uct kfd_node *dev,
        case SOC15_IH_CLIENTID_SE2SH:
        case SOC15_IH_CLIENTID_SE3SH:
        case SOC15_IH_CLIENTID_UTCL2:
-               ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
                block =3D AMDGPU_RAS_BLOCK__GFX;
-               if (ret)
-                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+               reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
                break;
        case SOC15_IH_CLIENTID_VMC:
        case SOC15_IH_CLIENTID_VMC1:
-               ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
                block =3D AMDGPU_RAS_BLOCK__MMHUB;
-               if (ret)
-                       reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+               reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
                break;
        case SOC15_IH_CLIENTID_SDMA0:
        case SOC15_IH_CLIENTID_SDMA1:
@@ -184,22 +180,15 @@ static void event_interrupt_poison_consumption_v9(str=
uct kfd_node *dev,
                reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
                break;
        default:
-               break;
+               dev_warn(dev->adev->dev,
+                        "client %d does not support poison consumption\n",=
 client_id);
+               return;
        }

        kfd_signal_poison_consumed_event(dev, pasid);

-       /* resetting queue passes, do page retirement without gpu reset
-        * resetting queue fails, fallback to gpu reset solution
-        */
-       if (!ret)
-               dev_warn(dev->adev->dev,
-                       "RAS poison consumption, unmap queue flow succeeded=
: client id %d\n",
-                       client_id);
-       else
-               dev_warn(dev->adev->dev,
-                       "RAS poison consumption, fall back to gpu reset flo=
w: client id %d\n",
-                       client_id);
+       dev_warn(dev->adev->dev,
+                "poison is consumed by client %d, kick off gpu reset
+flow\n", client_id);

        amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, rese=
t);  }
--
2.17.1


