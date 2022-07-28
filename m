Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66BEC04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 17:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40AAF113BA7;
	Thu, 28 Jul 2022 17:10:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4BC6113BA7
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 17:09:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTNnXbyv0m3OXy3TN3Oifnr6P6G9yxri895411cXU2DcKKNTqrD9aHuESUMQlW+hc4qeHD26rcFU8BnxvhJH0pL0D8e/8ccBKyha+5EcCL86jwiZOM1y+7Om8dBJMA5iuFbzSl2+Sj/KZBpRjV2Npsx/md4s9u8gWmsam/cyEResUQi8b4c/LFoYlDdrsiCgbt65ptKhePdcA/QpII/KPA5PIcn9bLtEeXXnMC2AuVM0ymKUXokWuFRfnSbDed/cjB3I+BQ5nP5/tvntv8AVvJAWqP1d4fFgXnfKrUiacaEX8uVU0dfVOZBq3+BQM9nW9+k2sXyQXkVifJQPzS7eMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHFGu7UOSGqVLjABVSfD8+Ozc7FIp7nYGJW4zPQN/RQ=;
 b=Tj7QpabP8B6L/etL4J2qHaDxJNG10jkmMPy/3oLIzCvpNnU3BkPRCt6PjwhUtktFVLgPtK/UCuo/q0XqhxwU/hKsk2MqNdvaY1SSALkanS1J3E9f+pe+/ibGjMK5UhFvB6gRNicwFQ7q35tzoAKPEC+h6Qbaibsx5MCiWQxPzmQzAT11KZgYIVu+Gcnp7EVKTvrD41gEy3Md6AJXW1QUrMltHAVqyFF6/sJcVuQb0VNw1NqgJ7B8j05oLHm8EnHeQ5qeUS1wW2Qzt77473hJJiXplslSoDAdrLRWRtoI2o76r1DnYUVmAciusH3Rx/P7GM0bW4oyNtL1o//rx27Iug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHFGu7UOSGqVLjABVSfD8+Ozc7FIp7nYGJW4zPQN/RQ=;
 b=vKe9SKdDdKNmlhYJAUEO5UIvEMwH4dN0IA5KrQYv680xlaCuBQMa0tOOCpKPp+48LWufXT8d2Ui9VQ8O8HyziNaq687BCnt/+i79rP2VwMwXA1/PSFg0I0kIubXpF7+budhHJHLx918jXO6AlESYG4Sd4MBCzoGXgTEeXnlEYpM=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Thu, 28 Jul
 2022 17:09:56 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::319d:83ee:9b70:476f]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::319d:83ee:9b70:476f%7]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 17:09:56 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix hive reference leak when reflecting psp
 topology info
Thread-Topic: [PATCH] drm/amdgpu: fix hive reference leak when reflecting psp
 topology info
Thread-Index: AQHYoqR10VJ7xzE/fU+kXg2AsOT58K2UA9sw
Date: Thu, 28 Jul 2022 17:09:56 +0000
Message-ID: <CH0PR12MB53729A99311F0466623247BCF4969@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220728170625.2724081-1-jonathan.kim@amd.com>
In-Reply-To: <20220728170625.2724081-1-jonathan.kim@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d38062d5-0a03-410e-bd32-1ab33e127966;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-28T17:07:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2221cce7-98b1-46bc-9a96-08da70bbff18
x-ms-traffictypediagnostic: MN0PR12MB6103:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2pys/KPTJfEv9/JYSINyDUCMVCvbaan1wjHrnS27ufHQq49De7iXRoPregdQEs2qXHAguM5jznEI59i6sHB4ABQCcueS5mdBD5NFa6UAgzqMBudKJISRWHQfQk9gEydPORBK5x6mR3z1hu5ElRtnwP44ZguZCiRC5Qvkzc8Td3iBO786811/UcHu5ZuH986xpP1CEw5HBuoezFEv9VmKe0PFXENOCgqQ0HVuGr60tISaIhvULLxBoCjUVzNut2BecYRtmfSfklLFt0ywPidbl3vDR43n9USt4FnsbdJyeMMKBpQrviRyei5unXCJpoci9iFC/jO/7PNBcL2XclLdYKjIOp8238avdFAf/r3fxgnvc9utvAenk9Tgp49+p+/c6YDJaGUg05nL0Ky4RzjaISWWXypEDVJYbb8MMx8eB/+zzm3QxyEQEvD3Fi5TwWZIoI00pJcFqM7poFvjTs/p4OFA8QVcoeWr3J0CDgzC+EiqbZfMopGvAuDCJT3RTJ3ycMnoj5eIOARTdMRtgp/vhywrpfO527DvKpIFhsDEmjtuWLyw7RWks1J5gtlQMQOu7h7IQm/N+WxS+N1x8i8xykwiXXQBUv/17tDgQe86hnACHn04Hx9teE6RoOideHLVlsdDVsvDw3G61kI/ns30LrXSKBSm7MxPBAtZ+quW5TjpB2+qICsr77TIJUdmkqokgWp0ZWda4gJDXJCTZ8tTks5lqKyhHcfeSdkaYZcZULVXBBOCfPubyUGiw6Du+q+NlgFP7cAjkc3ECtd3Ghp8bmwqzLUGp2Ew3E5agSuTisiIx9srTU0AOk219HqnLFmr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(66476007)(5660300002)(2906002)(53546011)(6506007)(76116006)(186003)(478600001)(66556008)(8676002)(316002)(38070700005)(38100700002)(7696005)(33656002)(41300700001)(55016003)(8936002)(4326008)(4744005)(83380400001)(66446008)(9686003)(26005)(110136005)(66946007)(64756008)(122000001)(86362001)(52536014)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j89AHM+AYdMznL9O6G5puu0/HOCjs2UkRmFAwG/kMwHnO+8gR7nUDm1852v4?=
 =?us-ascii?Q?L6E9cUuGxEO6vQah6K8dJmz83ZRYnXW6U2c242vb04NM/C8I7v0quU/mgIWb?=
 =?us-ascii?Q?in8tv/FFXgGpqt0iwu5iYOKnkmBm249Avze1ZeyrMF66vRyqKJntO2fH82pK?=
 =?us-ascii?Q?ufLjOlZjbitHpI6JjpARHp4emRUSbm8+cpTL9BdFvrwOsKYiCyyIbVAXuWRi?=
 =?us-ascii?Q?+HEC6zRg09nP1n0GqFiPl6o8+heV2rXzYeBNzkLcCO+do5zmUFltFXfhtY3B?=
 =?us-ascii?Q?nLTqYo+rQeuqSVbVbigAbriMp263MuH37Tbqn6eJBKWdlivOnaEtzWsEtX88?=
 =?us-ascii?Q?ORyNjjGnV/HH1lmad9qiorOzvAIU3CjUuAWuXlC4mkMd4bz0e8SfqEueMqE3?=
 =?us-ascii?Q?TimF+xd9sN2cc7nsZ7tVV0QcOF9AaN7hZJJiXrHt9yBL7K8ivytAJfA6Fscm?=
 =?us-ascii?Q?b4Us47iu7BAT8jvzvwUKA0I/HsFhV7Xzpy88xn+/a5u1t2qvnT96w4ZtY5dR?=
 =?us-ascii?Q?R7xGJd1fkm/32pvnYqno4M3Zyd1qGdqnC1w+uvaIqn26mV93jeOLt0d0wz/O?=
 =?us-ascii?Q?UcQsHd3Xpvo5dqOCVANAeu0URctNL/TmxJmJGBk7vqJqFiWA+z/dsXKU/C7o?=
 =?us-ascii?Q?03YWqjO2j0OJonwyd0kUScP/vIAvleaXKicdbLCIWStpTqXSJfKhINKhCaMw?=
 =?us-ascii?Q?7XYl3fd1UHk0Mxfm7GGgxHrufJPbVphq1Bc0Rny7wH1BdcwhxdVDFGGkpQVR?=
 =?us-ascii?Q?el7NfE9mLPWUSDvLopHCgwKAS+MnuSJ/Jl+EzLzcw2j/t/sjo8MNE/Wbsh7K?=
 =?us-ascii?Q?Ach2HUwGeMqvXs8xPWvnrJb+0yR70wpyVF5lAb/Kv8GZbjNHLGTPIBVWRxpP?=
 =?us-ascii?Q?IBg+/m99XXm5ScmtqSP1SX9vxcskgF2n6x2IvKANxVM3T97nh8AwNQRBgcYY?=
 =?us-ascii?Q?5cGSMb2eZ8uTFn9UH7l/GlwCcihUNzAu4dKFovdAurKJ3ZIXOx/HII+ZULVL?=
 =?us-ascii?Q?2n572T4gbOPS4VMwrgWeraks+0ZWvu3M6iO+hdyatPMA/eBESCp0VP4/Ye0Y?=
 =?us-ascii?Q?ziLNSp3KECWDnOVfdeCot4gbWQia0FSLRHqA6t0O71XRXxgQKEEyj5zPzOMi?=
 =?us-ascii?Q?ne4QMgu1bId38TgR6251dUcU5Aaa2nUC8SoRkV5csMKzpwf7U0RnzthiDrg1?=
 =?us-ascii?Q?zF57piIkpR/1BikSZFwNoXEaXRTRc3rmvQCQiWCa1yLn4IzgxNqYv5GSswke?=
 =?us-ascii?Q?+RH7CsDa8DILE9dfSqO4Dg1LJnMcgTgZaVsaMs1va/8aU8v7oIFID+mewIz+?=
 =?us-ascii?Q?UvJNmrLxbsH4HH0d9rAoEW0+eID1Jq0JXRMJWy38O837quoOt9/eeXV3TvHp?=
 =?us-ascii?Q?PR+XQPAo94jKNoC1uad5zG2Vh5oe6gVXUqgY5ypNFU03K+VVaMVif5stLUo6?=
 =?us-ascii?Q?kvc+mOQrJoxgtbKbkXc9eSmFlIavvrkBl3yoX38+638vCGP6ArG348M4H3wi?=
 =?us-ascii?Q?Tfy/r0SzieZxrxEbJC4Izb1hUSqC7JMM8540GcWv9q6i8xmwB1USdqVrG03A?=
 =?us-ascii?Q?gR28+Rl4NMQ42u7uJuk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2221cce7-98b1-46bc-9a96-08da70bbff18
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 17:09:56.7032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xN/iXFHKnJV56L0SgmWqMaJDo3+nKmdY/XKgww5V4zQqvFTehaPtOAy4LacXyVF0ZUSKU69JDwfri/GWEJInfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
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
Cc: "Kim, Jonathan" <Jonathan.Kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Looks good to me .
BTW , why we didn't catch it on baremetal mode  ?

Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jonathan=
 Kim
Sent: Thursday, July 28, 2022 1:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kim, Jonathan <Jonathan.Kim@amd.com>
Subject: [PATCH] drm/amdgpu: fix hive reference leak when reflecting psp to=
pology info

Hives that require psp topology info to be reflected will leak hive referen=
ce so fix it.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 3ee363bfbac2..6c23e89366bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1292,6 +1292,8 @@ static void psp_xgmi_reflect_topology_info(struct psp=
_context *psp,

                break;
        }
+
+       amdgpu_put_xgmi_hive(hive);
 }

 int psp_xgmi_get_topology_info(struct psp_context *psp,
--
2.25.1

