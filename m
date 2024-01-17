Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEB1C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 11:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4019E10E109;
	Wed, 17 Jan 2024 11:11:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09C5C10E109
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 11:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXdz3ZdwCjFj95aXbnD1x/l3q+TjTwAtcudSUKqhTj+JQq3vfegJ/sLSQJSknUIFOiRWtWZbFJAk0K71Qc/oh024GTwibDtSGiRAHm6lHhInQPV6yb3/mMc9X9jsnzU0cVLDQeVqtFAVcPY+ZVn57dI3m8WDSTI2nqC7sJdQWoJ6M6GHs5lcn1CWSsAT8jmun++qJ479vP7XnHr5CA+hSSP/jlKUiM1tvcDIBspejl38xHV1UbXvdwbBhn45OULPmDew7JLBlzlcaXd6Zv27aVHipqi8fgOaUcGP5T9HZhzDpRlF/CJOl+1F8sew0/59aYgfFFrt9Z1HVlSTAJlb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+l9yA6pG3o7jas066pwPLw99vhEmG/K2jDEn+E3EXw=;
 b=GQypJktIOh+e1+xJ+xI5o1UQ2BFK1JSLR79BBkyyoGJbWDwDAZn364MUYDhIYB/yJjSyF3ZycS2BYbjK3rQARBUovawOZADQvlc4ldx4YavnpfS8aXH1G7MaFHZC0D3L9QAf/0OXAUTFxSDnzW65LVsCtDfUy72B6N8lzXlD1m/66LaxLb9ojEXYNkishvclkp29Y1bqDCpVxhSDw6h/OIbsMfX3PaqfYARIoq/t/Tu9Woqp1QIymfqhuS4pfGg0T5H3PpkuUqcAZa9cPXo92MolJaUlPUx7HpoIt2/LWeGJRXtFXj/hp4hP2d7z/HhkQuYtSwFdLq3pNfRPMZML0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+l9yA6pG3o7jas066pwPLw99vhEmG/K2jDEn+E3EXw=;
 b=kVN2S/w9gAdBe9PPzMJbm+z9MaURUHcXja9PTpeMcPGvHsM7HMZIsqRlp4p3GPZgNUwyoTVt6zjx+yAlDc8vD65JVxMnpE1D3KX6hDXScePegie5NFjMKYZr7VOtXJN0w3cY8dRhL2Sga10aLUtRiLIxJVcFCyq6xAWLkfwnxl4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 11:11:41 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 11:11:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13_0_6
Thread-Topic: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and
 smu_v13_0_6
Thread-Index: AQHaSFT4B/Amse4OtUiOCV4I8p53EbDdtOfw
Date: Wed, 17 Jan 2024 11:11:40 +0000
Message-ID: <BN9PR12MB525769654D72081918DEC822FC722@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0b419208-df91-42f7-9c5f-36641ae16d59;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-17T08:54:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB7023:EE_
x-ms-office365-filtering-correlation-id: 3dddd048-ebb7-4750-9732-08dc174d14c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VyKZMzOwB+LGxVB2kZPXmqzIQmXlMxT0AzjeoWlV9v+v6zmcx8Wz4MKhK0eLCI+e38V3J1ILS9UpI4gNFTo64yx8MD5gM5jzfcZAnTCG01T+sV7ha6VvQ0FworM1gqu1KTCTeH6MFW+PAZBVChRE61h7R3bzhijlpPV1CRpnp6Hms+fwaxEnWkvOH7XpAQC5XhZyPqYgws15PMgmTiJNHj8LPx7hG9ShyyOyqIqscZIkVV+o5+jQ4J2c+rMSaIDOHfG/Uf0AnOra7KzVjA7VDaM0bNnmFu0BxP46k9qy5KX5IoqT9EhjJsFwfLHMG3rvbk6s1qFXXbId7vmu3HnK2FrcgDkMwq+SpnOZITa0ikF4IuvWbrxHP1y6uhQhKdo2gRM+s9KwWGO5DePmssJR/pWFI/UqYtQe6qjB7tqIo8dfIpAgP/uWoUFx+9l9l4o2LcVRuhDVqw5I0QvprByNA5PPAzlWtwtapb4/5NtVVcbs0BSJ0PF+w/e0uu9Xir7X6mggIO0DRzXkkrWsKlqvga+06AvXAeJEzPZsvt8WgCbuW6yBBe6PSrH4GW+2cjs+J6CqQ9Td2PgYIlnI1rOAghwL6xuQw3f7rUzqLAJdAa+Rn/vGCasU+oS+481tPf5j
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38070700009)(55016003)(53546011)(66556008)(9686003)(7696005)(6506007)(52536014)(83380400001)(64756008)(54906003)(66446008)(316002)(66476007)(478600001)(66946007)(76116006)(110136005)(26005)(71200400001)(4326008)(8676002)(8936002)(122000001)(33656002)(2906002)(5660300002)(41300700001)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Iya/vn7dQH0IzzFbx9n+VntB8mYGDZL6umbaPz5jLyVHi352sc6b8IqWUxg5?=
 =?us-ascii?Q?99KUF8RbWL0bi4BDmioTScOs8cdGapmRHvOCCcn3fiSGCmBaWjeeiWn/id0k?=
 =?us-ascii?Q?qklnpDqYslewQHyB0pfDFB+DKUA6UxjKGZGu6Jc2AEobSmumB/4NHKj/ZEfm?=
 =?us-ascii?Q?0vl4guqbOlUPB+bkNfx/56JN7aSOOCCCmHzb4mkbdnkLRbGYKEFxc7Cuk7BB?=
 =?us-ascii?Q?oi5DiLvR9tHYGoasDmXzCey0gFX4A33ErvGIEeo+qA1X0fe8bI5NQyK9Jcj1?=
 =?us-ascii?Q?P0bT9ysHsI88jobA6BGLw5WkIAIQVg3Bs13g/I+qvYEAEmM/zACDkCX90ujS?=
 =?us-ascii?Q?8nLidadXIxNKvL/sP5PYK8bpsb+lie9/ZDw6Shc+Zcnagj74A93uD0OP13f5?=
 =?us-ascii?Q?9jWx+I4v++62/Yi0MfwjG8Z+AkIiJ7Qz/yL8c5OOE9f2VYsyho6vyWDR/D+j?=
 =?us-ascii?Q?1aLexrtm4fefaWvPWNatJM2iUYOlP6vcPrNdbGcYUjSxS8kEkt4tNv6lua6q?=
 =?us-ascii?Q?HLg26SsWA4RkNUFpen8mevCooCcf8JqLEnFD9+ScPo0EfQpVIJXjmnu3J1+P?=
 =?us-ascii?Q?Y272ci1FTHd+hcI8irgBgPO6iGTdhjJWKUV8hP4d61OxfcrNs4LvWYwASY+g?=
 =?us-ascii?Q?g5BtCezOUqGmZ1hQ717QjFa1laQLC6cHyECFI6497sWq6adgTL1M6fiL56Q5?=
 =?us-ascii?Q?fVomet5hS3KsFH3l8/1qcU9cfJuBPvIXbuYJsSjKGP+UABAesQhUGemjtGxv?=
 =?us-ascii?Q?EMSM78OBb4qRCtZAUST5oAT/xMe71p8AaSGFVt+EnERE/2wtITeep9b2rOk+?=
 =?us-ascii?Q?9hzBfRsWSu+PnpFk2wnIBSSy4bCrW02t7C2p2MqXOCJcq4FDqREG9nCHGhDi?=
 =?us-ascii?Q?gmZoYgG3MrBKVvx2AOL4rpAyW6O70IPfldKT412v84HcLK9BHBBYFAqetYtd?=
 =?us-ascii?Q?eLQ+/5REdMoycyJ8X+XKJIbdN7prRAzeJ9Kq7BSBmHjtyh0+Qzxz2l8Aguiu?=
 =?us-ascii?Q?l1mNK5qWQEmyYDD1ylTmQXLQakE+jrTTWQS9+UvQxTHnOWL8sLAIKj+J+4JM?=
 =?us-ascii?Q?+cAzwEpRh1cpPVzU6ZC+RpzkELTwUJwm87i2kJfGVhvEJf67kBOGFWlathWo?=
 =?us-ascii?Q?7tZ0cJecgxHHIqi8TeXD2uuFpADC8Jx7y++RaV+n3P3LkM/7j29SHDH7i763?=
 =?us-ascii?Q?il661wBEUSkkXyLfNHm16XCoiOUzgdETcrGwzKETW8KiNSLfDaz9KpNpGs5T?=
 =?us-ascii?Q?xYD2Q5jIkMjCzhQKCGkxpI69JiD5zYcmQtHAjrc04DdXjY0SvijQCwWZx09h?=
 =?us-ascii?Q?CAJh0k1kgG9UCqvazZJNGMd77g/A3YhsHcye+Z2oWeRIWbXuhrgtS/p5ZkNo?=
 =?us-ascii?Q?FvEnIBIG8J7Oj3PiLTodnPDqsJb/OAzhyB5JHauq+ZzyIWCCbcua7B3dQvTF?=
 =?us-ascii?Q?UBEeGcHnyJb2io5+elw4dxXLMqksqPUHVFKTiJPbKEoPkLslJp5pHNG4g4b7?=
 =?us-ascii?Q?fMqBOFTfwk9EBLfyp+kKJOiJXody/gFM8nBhCmFb0iWgiWmsbwKDmNPPAjbB?=
 =?us-ascii?Q?GtAyf4FIe/23VVhCxAhJ/x5VZiWkagLyesAWOf0K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dddd048-ebb7-4750-9732-08dc174d14c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 11:11:40.7465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ErocAQZCY94XOJTW2Elx8fdhr3/h3kHf7ZebVdzqCHrED6ojbCsEawWQcdfip0m14vq0pev78+REGoCAhmwqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

+       dev_info(adev->dev,
+               "MCA_UMC_STATUS(0x%llx): Val:%llu, Poison:%llu, Deferred:%l=
lu, PCC:%llu, UC:%llu, TCC:%llu\n",
+               mc_umc_status,

Please also print out socket id for UMC MCA status.

+       dev_info(smu->adev->dev, "MSG %s(%d) query %s MCA count result:%u\n=
",
+               (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ?
+                       "SMU_MSG_QueryValidMcaCeCount" : "SMU_MSG_QueryVali=
dMcaCount",
+               msg,
+               (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ? "CE" : "UE",
+               *count);
+

This seems redundant or was added for debugging purpose. We can drop this p=
rint since there is log to cover failures.

Regards,
Hawking


-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Tuesday, January 16, 2024 16:21
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13_0_6

Add log info for umc_v12_0 and smu_v13_0_6.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c              | 11 +++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c             |  6 +++++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 13 +++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 6423dca5b777..fa2168f1d3bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -91,6 +91,17 @@ static void umc_v12_0_reset_error_count(struct amdgpu_de=
vice *adev)

 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_u=
mc_status)  {
+       dev_info(adev->dev,
+               "MCA_UMC_STATUS(0x%llx): Val:%llu, Poison:%llu, Deferred:%l=
lu, PCC:%llu, UC:%llu, TCC:%llu\n",
+               mc_umc_status,
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, V=
al),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, P=
oison),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, D=
eferred),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, P=
CC),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, U=
C),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, T=
CC)
+       );
+
        return (amdgpu_ras_is_poison_mode_supported(adev) &&
                (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
Val) =3D=3D 1) &&
                (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
Deferred) =3D=3D 1)); diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c =
b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 11923964ce9a..51bb98db5d7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1297,8 +1297,10 @@ void kfd_signal_poison_consumed_event(struct kfd_nod=
e *dev, u32 pasid)
        uint32_t id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;
        int user_gpu_id;

-       if (!p)
+       if (!p) {
+               dev_warn(dev->adev->dev, "Not find process with pasid:%d\n"=
, pasid);
                return; /* Presumably process exited. */
+       }

        user_gpu_id =3D kfd_process_get_user_gpu_id(p, dev->id);
        if (unlikely(user_gpu_id =3D=3D -EINVAL)) { @@ -1334,6 +1336,8 @@ v=
oid kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
                }
        }

+       dev_warn(dev->adev->dev, "Send SIGBUS to process %s(pasid:%d)\n",
+               p->lead_thread->comm, pasid);
        rcu_read_unlock();

        /* user application will handle SIGBUS signal */ diff --git a/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/sw=
smu/smu13/smu_v13_0_6_ppt.c
index 952a983da49a..cee8ee5afcb6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2406,10 +2406,23 @@ static int smu_v13_0_6_get_valid_mca_count(struct s=
mu_context *smu, enum amdgpu_

        ret =3D smu_cmn_send_smc_msg(smu, msg, count);
        if (ret) {
+               dev_err(smu->adev->dev, "%s(%d) failed to query %s MCA coun=
t, ret:%d\n",
+                       (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ?
+                               "SMU_MSG_QueryValidMcaCeCount" : "SMU_MSG_Q=
ueryValidMcaCount",
+                       msg,
+                       (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ? "CE" : =
"UE",
+                       ret);
                *count =3D 0;
                return ret;
        }

+       dev_info(smu->adev->dev, "MSG %s(%d) query %s MCA count result:%u\n=
",
+               (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ?
+                       "SMU_MSG_QueryValidMcaCeCount" : "SMU_MSG_QueryVali=
dMcaCount",
+               msg,
+               (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ? "CE" : "UE",
+               *count);
+
        return 0;
 }

--
2.34.1

