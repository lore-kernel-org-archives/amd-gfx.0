Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A7BC77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Apr 2023 10:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8D8B10E0EB;
	Wed, 19 Apr 2023 10:24:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C74810E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 10:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z05ZMFLuwqqSBQiSP4EeDtoS6KZe6x4ZqaIm19S5pERK94QwAALEC5u3nyB383/QFxSdKbdqRV/bGoWF/4dduQbrF+j59oosJgMksDg0gTxps3AKDpwbliiwPj2mygFFoZl/tYIrfPBJH2mbwMpv97FWIanYxUceBUkrXn4YNCqD5WRW+xjjRo8CrvQppw9ljVyxdQQ6+aVCbhdi4n/XUWEYES7RKKwY2xM2+3gAcC7hqDrbfiQuCDBy13RTVUdleZGiK9WrKdjm04BfQtBfNj8wiJhNdu2Ne6/u5cWlt+Witb96cBEsccNuC9a4tpb8ZSjxbEc0cmk4P3PoSVj9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UhlbafNdoFjaCGrQDmx1nXZLi0oZGul26QuoUXhZP8=;
 b=VMXJnzkGhq2/FXECkp1nm1OexjZzH95ojn4l2UUjO0B6PRB6ZrXtY1ggQrqLdONuJxg9KY3zdBQuXpECr2VbK8hwhRkZEO9Iq3Xh8I5g9lpqhKL38cS/AFYXWymsgLYcXjZs2T19zPnP3B6guxgmmD2jQYmDBGzPJRQGRmKts6Xc/RWh4rWyzccJkZ7GMoZ9IfZkeezV5f3/Ca0AhnNf/bvi0F0TQWbxkMGxk1FEeoth+OqrfMIpKF6cNtpJzGLKJpQmeHDAIGKMNKPmQZJeRzsxUpmaos74N/WnateXszJZC8wDfjK5f2sqeFwWumUleUF/3SrMK28ENeDf+/yZfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UhlbafNdoFjaCGrQDmx1nXZLi0oZGul26QuoUXhZP8=;
 b=AT8snoCRcSYYDiqPESyzr+Mty9FaaPZsuXQQJovpObkIdzO0wo8zDewjXi4QoCSTcAIxO9eEjyO2r6fuNeo9K8CMa5OjTZZpaT5g2WljlkTqF0hlirx6ul6Kuu5dvkXHAWVwBrTUGjiZhUVhvP0c2Y5N3dCDAB9cdsaB9Uu8P58=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 10:24:15 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 10:24:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Drop pcie_bif ras check from fatal error
 handler
Thread-Topic: [PATCH] drm/amdgpu: Drop pcie_bif ras check from fatal error
 handler
Thread-Index: AQHZcqMCb512mD0qj06rvlnIm7D0Tq8ybM+A
Date: Wed, 19 Apr 2023 10:24:15 +0000
Message-ID: <BN9PR12MB525799B54AFCDFEF7F40F713FC629@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230419094003.804-1-candice.li@amd.com>
In-Reply-To: <20230419094003.804-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=040c0232-e162-45b6-b9f3-2872cb93bd0d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-19T10:23:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB8350:EE_
x-ms-office365-filtering-correlation-id: 384a493d-19de-4fed-a5cc-08db40c039e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jaJTBTI6gT1xRH2thLHVOs6UGFJ709eFII/F/WBLd4lXcuvQ0rLpeO7YTmw6D0sKXJq0P6PFPwGyO8icA4ABOKEBPuGeBQG1mchnEMY81VVdbnl7sPVQVdi9l+sfDJsi3Rw+VVywFZaZhQUv4Lh1SP22RXLEP5P9kbxrKObx4PvLKpaWQuZMIixdfvkp3cxwKJHfSKc/SzWlo8ey3+ubdHu/F37E80HrJQaKCCxH8iGHl6bJP8HH6ZWBa/fVxNicZS2irIXvVknaivyhRhUxoNU3n6qErYjC2CJJ7ZqV1+YsSGD41eb/S2dYtq0/taFdE4TQlQxN33BfxC1QI1iNSYwIiOBwvZC8BRARe1UTiqegibfkWOaADH1hJNXpGcXozoJlwGABtLgC19NnS0BKgBjA+PeNUwUuwJH51VGXl68j4fqktsK7tZ04v1L4rPMyeiV+rLHseZ83xhTKqBhsgSyIL1LZTlEqI8Bmx1ptz1yMrvrPtxfjmCFwa2TAJoj8v/u5Dem95M/AlnUR+P25EOVQvCfPkCWiojDzzcSE2s+r/+eNvL84OIrDtZgMr+FJnnWxpPVh0WTUoL/OybD8YCLopAErmL9OktCMyigYeuWjrcczAn/Tv//+ljQqTdaS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(110136005)(38070700005)(86362001)(33656002)(478600001)(122000001)(41300700001)(8936002)(8676002)(38100700002)(5660300002)(52536014)(2906002)(55016003)(64756008)(66446008)(66476007)(66556008)(66946007)(4326008)(316002)(76116006)(53546011)(6506007)(83380400001)(9686003)(26005)(186003)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zDdtTjgLuCZHwHOSUTL1YklKc2UjmALwyZf7fv8TIeBZ4Qo7vWahHEUocgnr?=
 =?us-ascii?Q?SNnpMvTBX0EuvU0bjeN7Pd2cFp/YSb4knSBzxQ/68aA4fi78LWq4/xopMrv3?=
 =?us-ascii?Q?JkpGWQDYRF8ZvL8HEi2ioJBIqd2Tf+JBylmLRmdaXR1m7uKUCF7+fH8vGjjy?=
 =?us-ascii?Q?vqn+mPKIb9gA0qBvMaaIlQfqvFqv+FG0tMl1OEfAmrjutWsU1ixARHjvI2mi?=
 =?us-ascii?Q?pT+5MDJN/iGDO1rFUuRU0d4ln2Z/k74keJXdqXk2H5fcfVYckCnn4waEbrU2?=
 =?us-ascii?Q?uiedG0puy5RuT7g/edYhIlGR7guzrb5VhLf2RAZCAfhjS3O9OiIGe2rQAt64?=
 =?us-ascii?Q?hkFtxwqHzcrexJeTrefh6HyPwu4Awo0UNsC7egenUymI4BAKjTDeQbkCRhu1?=
 =?us-ascii?Q?3YD90Y9gdQlUs9BaHvLYFeI131LrLS0gMhNNegZketoCt2CsSN0DNJD0IrY0?=
 =?us-ascii?Q?clqp7kMcA+M0+WnoadAkVNhUBpSrugGpDPysBBE0I2iyFUJKQ/9fKpTOzCTw?=
 =?us-ascii?Q?8rOKA1pAjgYiT2gPSoHI4gnZd9e0cEVZkptazUD/H5hIdoFU8dTLJVH/nwVS?=
 =?us-ascii?Q?Mq40JcLuG7u20Mpeh+kMRpDuibUn2Ngm48un4Pv/BBOF5vbQMiU5SsnOJQ8I?=
 =?us-ascii?Q?yG5DC2Tq5AMv6So9yWxpUnSGlSZDVbC2aLppvn5UXuQufonJlR7C75XFd2Xo?=
 =?us-ascii?Q?AKVypqpaE3VYiSo0vMVUGAW4EVN2GYwn+jBXxnrAm6elVsh3Riyzvbm0BiWl?=
 =?us-ascii?Q?6pLeFlVno0czmH0hTBD1LZbK6X8e9aRefdmBtZeDa/dLtTa8QCC/esmiKMQs?=
 =?us-ascii?Q?98V6SdZyJ9OWUIhTpRzqIbVlsGeE1+YMKg2YPYzcdxJQnK7iwV+n2ibgsjGr?=
 =?us-ascii?Q?EzatkLBpkw0SSL5vc7Kq5v8GZicvw69iiqYTaropnBKHG6AtBwv3sOydFcVR?=
 =?us-ascii?Q?bTTjDTQTynRYX/BdhwP22Kph6qDHhqHZWYspoHOy0Ff+huFqVQRQyYrTz9yy?=
 =?us-ascii?Q?9/OazAsWqzTWjwmTboH6hpJfUWAa+YgbLXCUFQvtgHz71RxiBFawU5z+Lnwz?=
 =?us-ascii?Q?U2CKRaFZL1zOiokeaj8CRJJOr8JO7tlspI2CoDTudF/nsyTqzo3/kbE1ehGI?=
 =?us-ascii?Q?OrWg9LVm1gyU4zYIiIe5R7Em2YUbelVngewo6lg70OsltEsGGkSWQUDXOBxp?=
 =?us-ascii?Q?dpPLaI2fBISmEyhrIX8ti5b1C6iNuOC0LTTf5Uf5LVDgeLpJOLMRLCGPw3Ir?=
 =?us-ascii?Q?Sqp2UYncyy3sZ6Ps/OQ/RRMHS7X/XLwI2tRPp+tn82n34EN469TZwv5SrkWV?=
 =?us-ascii?Q?X0s8UPJoHrEkyPyk9nC0U51MneNhkYEJYsCCtIXuzpyH3SPglGccm3gTA3c1?=
 =?us-ascii?Q?3pohw7NWEKxz2hEaDW/K+zr0Zyo/mggeAZQkQC8fnXt3vG5GcHJ/CnAdCrbl?=
 =?us-ascii?Q?BBqFhPTgqVttEhF9bA67E5oRDKXnUhm3UsHorlWXiEoO9/MrIshHF2pb+Cy0?=
 =?us-ascii?Q?fMtHAF140I/TZisfoBlSHf0ES8kLrMPgNqKcikM+P5s+LPwAng394To2E+1i?=
 =?us-ascii?Q?arroM4LHOfocBV1mV5g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384a493d-19de-4fed-a5cc-08db40c039e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 10:24:15.1899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: upRZgtXZDTl7TMJQsvuM5FUmTQFM07K/z+jZndTfVHbESVb5fZedb+2buh/i5s9P3QBUP1G3CnCQkxOhlqSIVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Wednesday, April 19, 2023 17:40
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Drop pcie_bif ras check from fatal error handl=
er

Some ASICs support fatal error event but do not support pcie_bif ras.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 3ab8a88789c8fe..22f401fd1901cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1597,8 +1597,7 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *a=
dev)  void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *a=
dev)  {
        /* Fatal error events are handled on host side */
-       if (amdgpu_sriov_vf(adev) ||
-               !amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__PCIE_BIF))
+       if (amdgpu_sriov_vf(adev))
                return;

        if (adev->nbio.ras &&
--
2.17.1

