Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B50C0032E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 04:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9A8910E546;
	Wed, 25 Oct 2023 04:00:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E16A10E546
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 04:00:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEBsl8GHcgSSBhq9i20FYCiif1hDqhkCNlSEfNfNWEqgX4a3AAWlSRSOlpywDRlQGWyAaFWuPEkUZO/hjnjfpkGpAXph4dWQ9FZ9HGnfPxhcRWQAbAMajnUhDnl8pyq0TSzgBeQMOJab5gbP1/qVHym1zikdeTwYoeSF6WEcZPol2ZQkX6fTDGoyjxNW+vv9FSdgtnIzN+ESJjBKWVf6RuE9AmLRdrjr0kk14/ZFqEq55Lb6rIp61ogaG6hp6onFsrEEWZxZ/Gef3yHRjGA1BijZYyiV5sUDMh1LF7PakHdW1g11OdfehyAvLcP7giDPcyuQPws8FjOmRBQrVG1ZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnKvMmQXOwuME7N62TsK1oDI39C689DSL2InSCs3yWY=;
 b=JFPcD4BNA+h0ChVIMzEB6md2L00GEcMz7+2WeDYrURyRwhwD9z/G41RIf129ovf+JgQ38CoeW8TSpq3rgq6gZ3Gjbi5R9+xvCaXo1kJVLakYuXtd+qR5ok/D9xvkHx3bGNTMRMYdGHkbTytBVARBG8wzxaTIoxJQZL8LSCH+Lw2VOlAjUMm8znIJcf6vnFl90qQaMBCJyLLyLzrs69Elt5k5yWqiESg8h9R+Ssl+nUgk5CG2UVoKLfieKAnmq+5iFwxg9O81bjy739TnQnH1vN3Tr5/txh88tASUgAfllu2gzJGJ4vgeBHNCLItOrtXkoOD/zaRRZtVnOqEey8RieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnKvMmQXOwuME7N62TsK1oDI39C689DSL2InSCs3yWY=;
 b=KszeHmb9zldXsexM7wi1pkxbdPOM+iC2c7HN14zBTVWF2xbYbcLI1nnbFN4F1Ds6f5UilhHqVbWQUaWFJNh5izK4vvvdlZDF28sAqRZZxQtKDWPsF3hvrWtgaMe172BOzkJFq6qjWc/yEsr0fl9pg+RJguU328igl5uxuy29w1g=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 04:00:14 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 04:00:14 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: check RAS supported first in
 ras_reset_error_count
Thread-Topic: [PATCH] drm/amdgpu: check RAS supported first in
 ras_reset_error_count
Thread-Index: AQHaBveXwmGsz9rQO0KYBsB8O/Jw37BZ4Xqw
Date: Wed, 25 Oct 2023 04:00:14 +0000
Message-ID: <PH7PR12MB59974080014B62FFAA910BCF82DEA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231025035841.23300-1-tao.zhou1@amd.com>
In-Reply-To: <20231025035841.23300-1-tao.zhou1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=daaa59b8-3591-4463-94e3-34d8f719c916;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-25T03:59:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA1PR12MB6919:EE_
x-ms-office365-filtering-correlation-id: bc813a2b-f00c-4140-bc2d-08dbd50ee4b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uq7D3GxNKoxESDXv1K+/sMwOSJh5nTS0oaTXOScZeN/qjSAm/6OVaZrgfNnPHV1m4LH01xP8Tbuj2RBvO6HeFvRqgiHRzeGJoLr22BpfLG+L0eLqj//gIjzFvchzlume6yz7cGhOHaG5TSF1Oxnrg+cRVqxrPYIbOVZY7/2P3O69tVey3xkz6sDopnvhU60hy6msCkaHog778rxTnZVMzNbJuIhI95qROMnF7CebS4tUqVfQmtmMeBCpKlq+N11QZzoa6EoMwNCB310vsc5APaXuCuwF/nfKxP4Ic10bXdTYFIdGuFsocAA2wOtmL5WMX2to4aZZmg+7yT8zZu/v5pdfS/SgkU1Jr4Ospo18eI1qTm6X6BHI/qgMId4z6ZT8VW16jWJTjVIUwCSzYXosZhVORaG6wjFM10FsLm0DsJn5GaS4Y005aUoA8s4z4FR3UcGaXnDqrX7gBOK0WaiYhSP2kTj1zf2vl/b62Xbwv1+WQaQDnMRzuG7+FaiN21V3iwEg2RTIzYOZmFf5MuX1XENaqYcXoMZm5FBv5x++TS4HW9xnJUd4wbqUTAK3qKaJaB/7+7g3UMoIr0ZhdM+qsRhYzwhdJTIpQBd6+g3YWPSslQStJjLLYczTL4IHP/yL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(55016003)(38100700002)(122000001)(66946007)(66446008)(76116006)(64756008)(71200400001)(66476007)(316002)(66556008)(6506007)(7696005)(478600001)(110136005)(53546011)(9686003)(83380400001)(5660300002)(86362001)(52536014)(33656002)(4326008)(8676002)(41300700001)(8936002)(26005)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tS/hWX2zmnwS14lUqEoLVoVtius9L6QFn2N11LIe+iLx9s9XJyKrQrfDoPNQ?=
 =?us-ascii?Q?j/pk2Vc1poV4fXHJ+piIIpS5db6P3OBtPd68Y7NOHYYOZ7RpLE/4pRDqSzz/?=
 =?us-ascii?Q?pXBZqKOyh46hqXXWXTHBa48Oz0PLwSQ8FldY9+Hub15P7gniYfZS1pJAMQWw?=
 =?us-ascii?Q?KcABp2J/4hC1b43zconMSwjFnlG/O6bRFgHwDr8quxhVI2K6XlbO7rgtL5Yy?=
 =?us-ascii?Q?qi0uaCFG5taDJZtvyCof/PEb/IuFC2zOZ8Uf5nvjmg+N2jmpgIpBX3CPL1WC?=
 =?us-ascii?Q?wHGuVDWIk4qIejAbWmgcp3y5nE8K+bhN58Q2DlR3UDv1Q5HUyeoiDs+NTEC5?=
 =?us-ascii?Q?QvUfpHzIItoXVM9r4GjmTufpmEJhpXicXfUz6IjCyfqi0TO2AFo8HKHfG0yQ?=
 =?us-ascii?Q?isdtTat04Zhj78ju3QdeEGs3RKI1ylU1MmObmEnZpOOVyp/PGLKGSvcSAxup?=
 =?us-ascii?Q?ETVkjNdB0QU4Uk758Nr0B8mnt32dLSjFRZ/PfrrX2Trn9dDRcToQT6MP6fGT?=
 =?us-ascii?Q?v1RlhXrRkLUWbArGY0Lc1uUm3UUWZ02IbyNnyOheq03wvYsTM0GhLLyQTlEs?=
 =?us-ascii?Q?YyUTkjuZaZGMLJEAT+0m0AkJrP2Qt15zb/VrgTB93MIWY5BD0DUO/js3lVre?=
 =?us-ascii?Q?S0S+HxlnQ1WkitxBOkNs5k6+yrpWgyGbzkmFlng+G9EjayOX8EDGXFG34S/N?=
 =?us-ascii?Q?JQ8egIWLOO0wN+gU7itScC2KKyJJJDZgKYzbdN1ZMYh4BUFAPNFivF+wwGzK?=
 =?us-ascii?Q?mzcDgh+bPLRlrIiIPeJ67Y8QlcD57q1n9OKrqUso9wR3HxU3izU45TXSHN8M?=
 =?us-ascii?Q?8Xi4RvdGtzRK29Q5kgSYRjElQQuV4NxqK22ctMDoTZVAGIcr1/ehuEgmvBoq?=
 =?us-ascii?Q?4qfnlOECfAZJjsReSRKVd8RBJCQv5vLm9f467OOrQI98hHSZOc0EtlVzEF6I?=
 =?us-ascii?Q?an5mJZcWvUDdBiUPmj8dW3oj2Eq5/uYU065jjt4N0BL3dEh6jUqhmzGpQFYK?=
 =?us-ascii?Q?j0LU/T6YJ9afwW7m2AcJZ8Jjo3lRP8guVlTOP9RK+q7u57eSemmE9ZlvDGI1?=
 =?us-ascii?Q?ioqgUpcsHZKDmaloeV1DVxnj9RRTnnWcAAMO1rUW5z+njGWGkuBzIIGF109c?=
 =?us-ascii?Q?cTrL2Jncr8ww1E00hM+SmSATzVRdhfzyKDqU+6bcg488eX75giXn7l+FiG/V?=
 =?us-ascii?Q?o5L/CX+MAV0l4fW1Ad5m2RvKH+PNzbyISMBjgfLYmmp6irpR8jr697G9HIKA?=
 =?us-ascii?Q?KysHZwg3wq0lbI3Xr6dHnriknB/xDRcePLvNxBjqDG+MmB5HumT7CchTEanB?=
 =?us-ascii?Q?Yrv0Ytrq6rmbwQMJOej/LRaBWa2QTNXhgx0rUEEvJTzAQtyM9tQY5QXgPda7?=
 =?us-ascii?Q?Wl9G39y5EDiho789OV/uTg0EOa6W8ow0v9gF52kPDdRo7bMIMoQqhBJC0bKC?=
 =?us-ascii?Q?H1xFizfzsHHebX2W6IY87mhg8CRunrSfCrGh0cIn6qa4zblxC4356dkPdj6v?=
 =?us-ascii?Q?X0YlARzh51+bvE0pzmiuWEKwYGerZnIB5KEzC+AliXFJOWM2oCLhU7vb99Bo?=
 =?us-ascii?Q?neegFmumAiT993ZuT1k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc813a2b-f00c-4140-bc2d-08dbd50ee4b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 04:00:14.6285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPLvf8zVeynL4kv82NSbsl1Qx5gQMk9/+sn7jnL9x4PQwnSSVPN9XFU+Rox7LmPE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, October 25, 2023 11:59 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: check RAS supported first in ras_reset_error_c=
ount

Not all platforms support RAS.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index c71321edf50b..a6cff4a31c54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1233,15 +1233,15 @@ int amdgpu_ras_reset_error_count(struct amdgpu_devi=
ce *adev,
                return -EOPNOTSUPP;
        }

+       if (!amdgpu_ras_is_supported(adev, block) ||
+           !amdgpu_ras_get_mca_debug_mode(adev))
+               return -EOPNOTSUPP;
+
        /* skip ras error reset in gpu reset */
        if ((amdgpu_in_reset(adev) || atomic_read(&ras->in_recovery)) &&
            mca_funcs && mca_funcs->mca_set_debug_mode)
                return -EOPNOTSUPP;

-       if (!amdgpu_ras_is_supported(adev, block) ||
-           !amdgpu_ras_get_mca_debug_mode(adev))
-               return -EOPNOTSUPP;
-
        if (block_obj->hw_ops->reset_ras_error_count)
                block_obj->hw_ops->reset_ras_error_count(adev);

--
2.35.1

