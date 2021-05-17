Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A82C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 18:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4180960FD9
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 18:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4180960FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A50076E083;
	Mon, 17 May 2021 18:11:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD7D36E083
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 18:11:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgtrDReCS7b1kgH9XRudi8kBOwipbUR4MjZaeZYRF23ajmu7FwsaHHxfXn1ScrW9g1iirBb1/pOuKplhpjQg9ymC4K1qRz05I4ehJEB3XHGB3VWDezGgcQtAfGTPm0L5Kl+0ExRUxJ0TtwSXv61UZyp4dfQyXVHcZPVP6VeiEIVyfQ23AqoaFbRO1va154VuIOjT4uJs23JC3O885ojfEVtm3DYCFHsxiwvciUjmaS3bYwASGmXiDH+ZF5pvTCqkQ2R6wYoQVyjlecximzX08fDSR625aV1H4BtkGTal26lkl92yMv43ananVyyUn3VN2G0VHsZCzAOTHel3p9rOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZEtCJkie3CjCaHJuY57GwDAaeu3XYbUayLY+ElDOb4=;
 b=lOsWle7flRdDX9jjXH80tpGI5X3EniqoaBT1s1ba0ZJSrHcOSX6I1DU7LegD8ziuhJh1Cg97ZUk07Rw5pvkfd+VRazVP0tLsCN3JD/BBJ8+PFRstIOK/ps8SXeiiLNeZHp0L/gb+/hML+eNYg7gA0JLtnHYXM8UiRotaFhJMuaQ/+GG3FhTXlNPoQZ+3I/DOsvIB6ZJ3qKVr9gqygaHYQD2pNSF2dOm1SsgzmqzVoMrSGeWlO9S51OMcr6XnyxNmPGnRtRxWZ6trlvfp+102J3ZxDmTvcbXmrOU+rQ+HzPG7SuEYyXDVOdr05DMTsetKfv1/r1yq6uk0Lo4XIjXH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZEtCJkie3CjCaHJuY57GwDAaeu3XYbUayLY+ElDOb4=;
 b=kxh3eOZvaJGq9kbRszZKrEA4IREE6fkfNZYCzto+sEqLeTeb+0RtOS5dquaKAjvojdouU4+Bs348CdeIuWR2duaJ2EylnM15Qh2Ol9lKY56KyJBg0X2L4ghZ3oBQP+sH8ClepghmR5MgH6iOTy3JVBT3mLL0kyhSwZhcul2LNco=
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4841.namprd12.prod.outlook.com (2603:10b6:5:1ff::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Mon, 17 May 2021 18:11:26 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 18:11:26 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/2] drm/amdgpu: enhance amdgpu_vcn_suspend
Thread-Topic: [PATCH v2 1/2] drm/amdgpu: enhance amdgpu_vcn_suspend
Thread-Index: AQHXSzSp5mPV26VxskyZspFLvn7FIarn3o6A///CqwCAAFCIAIAABJ2AgAACWYCAAACMvw==
Date: Mon, 17 May 2021 18:11:26 +0000
Message-ID: <DM5PR12MB25173E8B288010950417C2E2E42D9@DM5PR12MB2517.namprd12.prod.outlook.com>
References: <1621263428-8631-1-git-send-email-James.Zhu@amd.com>
 <1621266752-11959-1-git-send-email-James.Zhu@amd.com>
 <85106a30-90ee-6e04-65cd-90f8e290c3d2@amd.com>
 <15dbc004-f5d6-6722-d7bf-40ade20d2cee@amd.com>
 <3c6a0bf3-b4b4-0a93-573e-fd9ae02f16a8@amd.com>
 <8659d46e-58b6-d090-f95f-2ad9d4533f0e@amd.com>,
 <184b0f99-fd6f-6180-50dc-ddb6072d006c@amd.com>
In-Reply-To: <184b0f99-fd6f-6180-50dc-ddb6072d006c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-17T18:11:25.206Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72310def-8f1f-4b09-799d-08d9195f2fdd
x-ms-traffictypediagnostic: DM6PR12MB4841:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB48418C4EF22918CF91EBF8EFE42D9@DM6PR12MB4841.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7HI7zQDAXjWvcGFRaYZrzN0XlH2V+ioLuC5RMB+tDF2eAEvNyb4GZ4vf3BNBsyTmaEChDv6/XZv81wIMT1bdfUHgYZn85Pvb500uxGb4ihWj45YOPKlo0S3oxopeDhjIvTSJ3YThGLXAldSicMrpDudIrz8TGUvRpwIOMJ20WXe6MLRqWYw9bHYrJ5XdRWZh3n3JRL+/7yxfLzmm+3kIDRsNHY2iK5zQ9L93ABbGqUJnopxhe/54uQVLQoU3LreIeqeFXKDzYfuIv22Hxh8jFM8mgFcJIAotlIFY1Lu6UWh/M09t5Tvm5tsAgf/9S5h5VXMxN9xFLY9gSqrihNPfuja5sjsS48c9oc2v7jn73tGHhvvIHA7DbVpn5utLDM8pGMi1etzXzCIwRGzxrhl9lMWiAxNWWC5aV8zTfHSbwykt0V/JhG+CHx541E/e2AbjaeH0HKk8cV94VBj5w+UiOjquQyhe8Pkg9jZZGxmO3MoG+WXIrmrza3/WbZrXKkEsxX+c7bYEMPE8NC3FlC2AYqonhCuqklkH2lqBR5kpBu0Q85XVx5QPhrb+GhwgAkwjdy5VGe6wmDbSNsenpQCtDw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(5660300002)(91956017)(186003)(316002)(122000001)(71200400001)(19627405001)(6506007)(110136005)(86362001)(53546011)(66446008)(52536014)(33656002)(478600001)(76116006)(83380400001)(8936002)(55016002)(9686003)(8676002)(26005)(2906002)(66556008)(66476007)(66946007)(64756008)(38100700002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?g5Ck15dMrUEzS2oLfeGF2bh3tX7Ya2fV1acgb7xYr7R6U4BusMRwfPd733P2?=
 =?us-ascii?Q?zwL1C/q9oKUCqymotUxh4jApct8/t9MtNIOVNA+oTnV7lW2mJwiJpL5YZJht?=
 =?us-ascii?Q?ktGZcbLngKRgdFIDW2t9Gqcaqqj3CPKG++bJ1Et0GQ77MM8aFmKwIpkl7jlP?=
 =?us-ascii?Q?AIA59fKxjjJvZ0XBjJYx71HcCibjdbko5cYWjnfmiq+KpM0yoy2au0C37Fwa?=
 =?us-ascii?Q?eZzn2BqDO9o2RgSfz4IIgxi25KD/K6Crqoxper43TYI/TLoQKMh7oUClea0H?=
 =?us-ascii?Q?J9X9S5vYBTXeB7DRRwSfsjDCtDNGEQkNF3uXyd154QqunM/V8rit2N0Qt3Zv?=
 =?us-ascii?Q?6ftnMXfgGmxO/K6ExMthDh4zpRk8NFRLTHnjmCqerD8xGyzbNXa6lkm7Y15l?=
 =?us-ascii?Q?t3BN/Y25W6SjvMpqS/upEdyP0rOd/J7GkUO3jzHitLHfkau51gsUz9cet/M5?=
 =?us-ascii?Q?DhE5Cb/+5+5T3bWl4spE1JuaPfVcOqn9TjaBfpLRjHcl7uBgCDvitfOE3xyk?=
 =?us-ascii?Q?wtFUN9/KKdkWK6mu6jcxDfuLhpoJ1iZT8K/3Rbd2yKhe9xo0ynJx44hmoq7x?=
 =?us-ascii?Q?X1IT0qR1jHC3ASz7HmWSS1T4tAFDYUP9Bv1d1J18tzIldl77lxHXdu90sfC6?=
 =?us-ascii?Q?TCHH9nQJUos6419F3S6vU3jTfeadw/l9UuG8Ry7qdbs0x+klQ61g6ZP9VkGX?=
 =?us-ascii?Q?Lkqb7F0rzIr4WSvPklCjb8vWwjmFjRSYPkTBri5dteGJPZ1lXx1Mmp+lV6ie?=
 =?us-ascii?Q?tfgnXuZEGQfi53iNSPTh77iFQU4EAS7EeiH0RlnPzNHl4wMcHXuFDIAlZR8+?=
 =?us-ascii?Q?ZP5cIPr3+yH6OCOGt/Dae8z4BXNPv1F30bASaKc0ZG6tVLGVETp1WrsAHHF/?=
 =?us-ascii?Q?Q5qx/2MVRRXHTBs+Xrh4rfgOflIz4ZE7M5UR4BbPsvsAsGjBgmKBB4GEfhj5?=
 =?us-ascii?Q?squjl371uJINcVOqHDCYgudCUDr5x1xZg+7uvlpAPeqAa4nK28uyR3zBCmQc?=
 =?us-ascii?Q?zYTFjHEpaEOa67/r3FrTk6uj0fF7U5XVRT7VNCpk7hibWIy8g/b1uOspr3vH?=
 =?us-ascii?Q?hyG3CmJyw+2eDE2IHSe0MTwZXgabfSlEDw7ZR8DQXuOQcUXFFEbu5GAwaWG/?=
 =?us-ascii?Q?Kc2QXw0/CRWXjwVKme/chmk8HrJzqjaFU9qgspnYJVLG3x11IelGsfxWmKFI?=
 =?us-ascii?Q?1ZwB0+v+4zHmYOcST1EA8c34j6hmkhanzLt0/iFgAR1UjjNmxd1a19Pq8tQe?=
 =?us-ascii?Q?UzX8ylPiZI+UCapk+A5BC3I4MucQEuMJadOybaFGuQgVWql+gBGt/KqwQiuB?=
 =?us-ascii?Q?b10=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72310def-8f1f-4b09-799d-08d9195f2fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 18:11:26.4017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JkfhOlWkFm/U1YAtcTTstmdcDBVgD92Q1BL7MoHBFYWL06QfomLvoUhIVrgMlVV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4841
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
Content-Type: multipart/mixed; boundary="===============0397466658=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0397466658==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB25173E8B288010950417C2E2E42D9DM5PR12MB2517namp_"

--_000_DM5PR12MB25173E8B288010950417C2E2E42D9DM5PR12MB2517namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

save_bo needn't ungate vcn,  it just keeps data in memory.


Thanks & Best Regards!


James Zhu

________________________________
From: Liu, Leo <Leo.Liu@amd.com>
Sent: Monday, May 17, 2021 2:07 PM
To: Zhu, James <James.Zhu@amd.com>; Zhu, James <James.Zhu@amd.com>; amd-gfx=
@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/2] drm/amdgpu: enhance amdgpu_vcn_suspend


Definitely, we need to move cancel_delayed_work_sync moved to before power =
gate.

Should "save_bo" be step 4 before power gate ?

Regards,

Leo


On 2021-05-17 1:59 p.m., James Zhu wrote:

Then we forgot the proposal I provided before.

I think the below seq may fixed the race condition issue that we are facing=
.

1. stop scheduling new jobs

    for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
        if (adev->vcn.harvest_config & (1 << i))
            continue;

        ring =3D &adev->vcn.inst[i].ring_dec;
        ring->sched.ready =3D false;

        for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
            ring =3D &adev->vcn.inst[i].ring_enc[j];
            ring->sched.ready =3D false;
        }
    }

2.    cancel_delayed_work_sync(&adev->vcn.idle_work);

3.    SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
         UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);

4.    amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,  =
 AMD_PG_STATE_GATE);

5.  saved_bo

Best Regards!

James

On 2021-05-17 1:43 p.m., Leo Liu wrote:

On 2021-05-17 12:54 p.m., James Zhu wrote:
I am wondering if there are still some jobs kept in the queue, it is lucky =
to check

Yes it's possible, in this case delayed handler is set, so cancelling once =
is enough.



UVD_POWER_STATUS done, but after, fw start a new job that list in the queue=
.

To handle this situation perfectly, we need add mechanism to suspend fw fir=
st.

I think that should be handled by the sequence from vcn_v3_0_stop_dpg_mode(=
).



Another case, if it is unlucky, that  vcn fw hung at that time, UVD_POWER_S=
TATUS

always keeps busy.   then it needs force powering gate the vcn hw after cer=
tain time waiting.

Yep, we still need to gate VCN power after certain timeout.


Regards,

Leo




Best Regards!

James

On 2021-05-17 12:34 p.m., Leo Liu wrote:

On 2021-05-17 11:52 a.m., James Zhu wrote:
During vcn suspends, stop ring continue to receive new requests,
and try to wait for all vcn jobs to finish gracefully.

v2: Forced powering gate vcn hardware after few wainting retry.

Signed-off-by: James Zhu <James.Zhu@amd.com><mailto:James.Zhu@amd.com>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22 +++++++++++++++++++++-
  1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 2016459..9f3a6e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -275,9 +275,29 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
  {
      unsigned size;
      void *ptr;
+    int retry_max =3D 6;
      int i;
  -    cancel_delayed_work_sync(&adev->vcn.idle_work);
+    for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
+        if (adev->vcn.harvest_config & (1 << i))
+            continue;
+        ring =3D &adev->vcn.inst[i].ring_dec;
+        ring->sched.ready =3D false;
+
+        for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
+            ring =3D &adev->vcn.inst[i].ring_enc[j];
+            ring->sched.ready =3D false;
+        }
+    }
+
+    while (retry_max-- && cancel_delayed_work_sync(&adev->vcn.idle_work))
+        mdelay(5);

I think it's possible to have one pending job unprocessed with VCN when sus=
pend sequence getting here, but it shouldn't be more than one, cancel_delay=
ed_work_sync probably return false after the first time, so calling cancel_=
delayed_work_sync once should be enough here. we probably need to wait long=
er from:

SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
        UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);

to make sure the unprocessed job get done.


Regards,

Leo


+    if (!retry_max && !amdgpu_sriov_vf(adev)) {
+        if (RREG32_SOC15(VCN, i, mmUVD_STATUS)) {
+            dev_warn(adev->dev, "Forced powering gate vcn hardware!");
+            vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+        }
+    }
        for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
          if (adev->vcn.harvest_config & (1 << i))

--_000_DM5PR12MB25173E8B288010950417C2E2E42D9DM5PR12MB2517namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
save_bo needn't ungate vcn,&nbsp; it just keeps data in memory.<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Thanks &amp; Best Regards=
!</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">James Zhu<br>
</p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Leo &lt;Leo.Liu@=
amd.com&gt;<br>
<b>Sent:</b> Monday, May 17, 2021 2:07 PM<br>
<b>To:</b> Zhu, James &lt;James.Zhu@amd.com&gt;; Zhu, James &lt;James.Zhu@a=
md.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org=
&gt;<br>
<b>Subject:</b> Re: [PATCH v2 1/2] drm/amdgpu: enhance amdgpu_vcn_suspend</=
font>
<div>&nbsp;</div>
</div>
<div>
<p>Definitely, we need to move cancel_delayed_work_sync moved to before pow=
er gate.<br>
</p>
<p>Should &quot;save_bo&quot; be step 4 before power gate ?<br>
</p>
<p>Regards,<br>
</p>
<p>Leo</p>
<p><br>
</p>
<div class=3D"x_moz-cite-prefix">On 2021-05-17 1:59 p.m., James Zhu wrote:<=
br>
</div>
<blockquote type=3D"cite">
<p>Then we forgot the proposal I provided before.</p>
<p>I think the below seq may fixed the race condition issue that we are fac=
ing.<br>
</p>
<p>1. stop scheduling new jobs <br>
</p>
<p>&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) =
{<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.harvest_config &amp;=
 (1 &lt;&lt; i))<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; continue;<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;vcn.inst[i].ri=
ng_dec;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring-&gt;sched.ready =3D false;<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; adev-&gt;vcn.num=
_enc_rings; ++j) {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring =3D &amp;adev=
-&gt;vcn.inst[i].ring_enc[j];<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring-&gt;sched.rea=
dy =3D false;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; }</p>
<p>2.&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_wor=
k);</p>
<p>3.&nbsp; &nbsp; <font size=3D"2"><span style=3D"font-size:11pt">SOC15_WA=
IT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UVD_POWER_STATUS__UVD_POWER_STA=
TUS_MASK);</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:11pt">4.&nbsp;&nbsp;&nbsp; </s=
pan></font>amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_V=
CN,&nbsp;&nbsp; AMD_PG_STATE_GATE);</p>
<p>5.&nbsp; saved_bo</p>
<p>Best Regards!</p>
<p>James<br>
</p>
<div class=3D"x_moz-cite-prefix">On 2021-05-17 1:43 p.m., Leo Liu wrote:<br=
>
</div>
<blockquote type=3D"cite"><br>
On 2021-05-17 12:54 p.m., James Zhu wrote: <br>
<blockquote type=3D"cite">I am wondering if there are still some jobs kept =
in the queue, it is lucky to check
<br>
</blockquote>
<br>
Yes it's possible, in this case delayed handler is set, so cancelling once =
is enough.
<br>
<br>
<br>
<blockquote type=3D"cite"><br>
UVD_POWER_STATUS done, but after, fw start a new job that list in the queue=
. <br>
<br>
To handle this situation perfectly, we need add mechanism to suspend fw fir=
st. <br>
</blockquote>
<br>
I think that should be handled by the sequence from vcn_v3_0_stop_dpg_mode(=
). <br>
<br>
<br>
<blockquote type=3D"cite"><br>
Another case, if it is unlucky, that&nbsp; vcn fw hung at that time, UVD_PO=
WER_STATUS <br>
<br>
always keeps busy.&nbsp;&nbsp; then it needs force powering gate the vcn hw=
 after certain time waiting.
<br>
</blockquote>
<br>
Yep, we still need to gate VCN power after certain timeout. <br>
<br>
<br>
Regards, <br>
<br>
Leo <br>
<br>
<br>
<br>
<blockquote type=3D"cite"><br>
Best Regards! <br>
<br>
James <br>
<br>
On 2021-05-17 12:34 p.m., Leo Liu wrote: <br>
<blockquote type=3D"cite"><br>
On 2021-05-17 11:52 a.m., James Zhu wrote: <br>
<blockquote type=3D"cite">During vcn suspends, stop ring continue to receiv=
e new requests,
<br>
and try to wait for all vcn jobs to finish gracefully. <br>
<br>
v2: Forced powering gate vcn hardware after few wainting retry. <br>
<br>
Signed-off-by: James Zhu <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailt=
o:James.Zhu@amd.com">
&lt;James.Zhu@amd.com&gt;</a> <br>
--- <br>
&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22 +++++++++++++++++++++- =
<br>
&nbsp; 1 file changed, 21 insertions(+), 1 deletion(-) <br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
<br>
index 2016459..9f3a6e7 100644 <br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c <br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c <br>
@@ -275,9 +275,29 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev) <br=
>
&nbsp; { <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned size; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *ptr; <br>
+&nbsp;&nbsp;&nbsp; int retry_max =3D 6; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i; <br>
&nbsp; -&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_=
work); <br>
+&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) { =
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.harvest_config=
 &amp; (1 &lt;&lt; i)) <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e; <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;vcn.inst=
[i].ring_dec; <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready =3D false;=
 <br>
+ <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; adev-&gt;v=
cn.num_enc_rings; ++j) { <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =
=3D &amp;adev-&gt;vcn.inst[i].ring_enc[j]; <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&g=
t;sched.ready =3D false; <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
+&nbsp;&nbsp;&nbsp; } <br>
+ <br>
+&nbsp;&nbsp;&nbsp; while (retry_max-- &amp;&amp; cancel_delayed_work_sync(=
&amp;adev-&gt;vcn.idle_work)) <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(5); <br>
</blockquote>
<br>
I think it's possible to have one pending job unprocessed with VCN when sus=
pend sequence getting here, but it shouldn't be more than one, cancel_delay=
ed_work_sync probably return false after the first time, so calling cancel_=
delayed_work_sync once should be
 enough here. we probably need to wait longer from: <br>
<br>
SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1, <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UVD_POWER_STATUS__UVD_POWER_STATUS_MA=
SK); <br>
<br>
to make sure the unprocessed job get done. <br>
<br>
<br>
Regards, <br>
<br>
Leo <br>
<br>
<br>
<blockquote type=3D"cite">+&nbsp;&nbsp;&nbsp; if (!retry_max &amp;&amp; !am=
dgpu_sriov_vf(adev)) { <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (RREG32_SOC15(VCN, i, mmUVD_=
STATUS)) { <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_war=
n(adev-&gt;dev, &quot;Forced powering gate vcn hardware!&quot;); <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v3_=
0_set_powergating_state(adev, AMD_PG_STATE_GATE); <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
+&nbsp;&nbsp;&nbsp; } <br>
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;vcn.num=
_vcn_inst; ++i) { <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.har=
vest_config &amp; (1 &lt;&lt; i)) <br>
</blockquote>
</blockquote>
</blockquote>
</blockquote>
</blockquote>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB25173E8B288010950417C2E2E42D9DM5PR12MB2517namp_--

--===============0397466658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0397466658==--
