Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FF8C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 05:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9422310E2FD;
	Fri, 21 Apr 2023 05:42:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5235010E2FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 05:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPIrmNaHg9/vzwFW/9+Y96MRtgAPz+fI0LughmhNC5ZvNZrEDw83kikn3s5TzDY+tt4bqK/Rz+QhpV/BPXAIjIIN1MDL9ONHXIve+0nD6buwnrtcEFpoZMFuoTKnq3hsjV0AIB/qCjxDeCa/ALB05kuHmGmbE9PH6CJKzHzaDrjq4WZ4SU4cdPUN9351secT0PsPrwR1r82AQDUN+q0aJZWpW6bO+h/wglyUDozGyiHot+/IStTgJsAxYHchcBSWeEjzX3CK4bnkxB/98cQfl6Xe/61KHik9HXO3Hgviv2M57pXvgsRB0gKAVmJNMOEtU6mhnGFF271nxClATj1izA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEZ1jQ3CtWpHxgA5uJYxJwMizTFgGhYBMCMdXXQKSqc=;
 b=GviUblp2FrIdW6TBfh6DhVa4eXKPqkBojTYmA92ltKSs6VRIdHjrmo440IyRTJiOvQEHVy5kVA+Wk9DgI5NrCoEuEQ0QJTcF77xLYD70o2asDIX9TAk5PlZtjr5rRMN9BQ6JtcbyzABelYzATkumCND0yXp4iw3g7BrJmX1wrPQ+G1cw7ejcQO8Xas19BODmyUKNXc1/Swwf78pTIo/2Jm1iDIdWBMOS8+E9n72Pwnd10ug4vvX+sgkSngb1WZYRV0QbboMGUMM5lMKocK84iTdK5/tFoFNgP0iLi9/vj0XIk2xF5g3EPu1wMmrR1M5b8pKqFNVLWCgWA3HgDA1Fxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEZ1jQ3CtWpHxgA5uJYxJwMizTFgGhYBMCMdXXQKSqc=;
 b=yGfg3XAqq9wVYs7NXQvzCYvgGZaa7OedE7hKhQxF57GINJbmW/JRooAt/OoP6UCc4Oq2mYbiJcMHVSWFD7cxiuqGv10R5hBTiql8/6AZvvJCLAtQCwUboyeUi04QBoNtNIfvvx2S7fTGL/tkJU+Wz21nSbMNR38+do8pxe0w+30=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 05:42:50 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 05:42:50 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: support psp vbflash sysfs for MP0 13_0_10
Thread-Topic: [PATCH] drm/amdgpu: support psp vbflash sysfs for MP0 13_0_10
Thread-Index: AQHZdBLx/nm/gVb2G0asrDk8MZNrra81PgRAgAAB+LA=
Date: Fri, 21 Apr 2023 05:42:50 +0000
Message-ID: <BN9PR12MB5257BF16ECB340739C69D23EFC609@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230421053405.1075529-1-likun.gao@amd.com>
 <DM4PR12MB5181508563FD7EB3B9EC54B9EF609@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5181508563FD7EB3B9EC54B9EF609@DM4PR12MB5181.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4ca823c2-a21c-4bb6-a2f4-28610d36cf89;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-21T05:38:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB8274:EE_
x-ms-office365-filtering-correlation-id: 39ed05ba-cafe-469c-c978-08db422b3e77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ATQgAI1Eo4ckUeVBGUg/ipKkYJ9yjO8KiysBIW3ojMKA/IIBXIp2YO4BFVQuZy83p9BFshjkXg6MCgK5CZihhMuG2bsUSqhovX7hxt1e5h/a8gQncuyaef3M7jW0ewXwszrPh7iM0FhR0CrYL0/ewRws82NPAWlkfb1itnqjHrOWov8msoLIoB8WRvpQPOkrHqWPnZfvZxJNELTZ0vhdnvlHR+xv+9BvNpYMwNiVroP+Fre9IKmdsis/VUgqEkgQTgwtz6Xc9rTNjO15gbudzAl3tCHCcsYLcMHyKj4u4yceGiUQeMrTayG0v6qozkAQU/MhWaSZIldDN762UXe2pNaqzjJDocM12oJB3mN0GeJ+3gQaSOItJYW8YYfgzS/3PL0COMfm3T6tPv3d8U8iHjEA6gUV6ELQMOC7JpRcCGgpxA4cjaBD2ywHWeZettwuFHw4tlVsWCmHFD2lsjslMUkZwoEXU1hPB6YBAIwvlXaTVEygKI1mRn9F6dIxmePACZmhr75tjdA3yjOAmc+7pVnnLqpMojR1Od3csht2+sn4CtN/1xjGnoSAB8bF/Oc9pzD9jUlMW/vozgo1tLW/6gix/xaNpvyatYMgtIPOUUs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(83380400001)(478600001)(9686003)(53546011)(6506007)(26005)(7696005)(71200400001)(316002)(4326008)(110136005)(186003)(76116006)(66446008)(66476007)(66556008)(66946007)(64756008)(41300700001)(122000001)(8676002)(8936002)(5660300002)(52536014)(2906002)(38070700005)(33656002)(55016003)(38100700002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ScohmcVGLWtBYkE1elFmhCm4+fAF/rYnUDJboBgTv9WFPVzLx0/SyAlc+W/p?=
 =?us-ascii?Q?T8srMe2sje5j+54A4SXR2f85jOWpQw8q1aCI9kQMHMUOJXJ2EfOV552M5cLr?=
 =?us-ascii?Q?HqDyLevpsF99tgf/nIQqjen1bSjP3fb6+ptjRuqveFKUALlk5k8BqSc5xDsa?=
 =?us-ascii?Q?IUAyUSOmbXT9n36UhAnZBbNabxN0BHL4ybBtT6dWmIh9GgJifu01ACRxfbRd?=
 =?us-ascii?Q?h8z6s4BXItsgxN7hYPUoFe3iawyXODjK4sy/sM1DLniRwlKPhogvi6QlOVwP?=
 =?us-ascii?Q?hwv759DDUo+32AYmRttJjcCZeTSR/V7BChGkhz9AqJl4RCyVhprPqlyjWQYB?=
 =?us-ascii?Q?ltoty6iL8fuzvCY3YtFkqqkZmQ7btJYk3ekSUPUBjuHIhwBR9JwWqvqsHw3Q?=
 =?us-ascii?Q?hJ9RCi0yZBZBlljoGRPhRnQ/FvU7ucEb99AFIWItQQeDhP5OFYgp5/pevH8m?=
 =?us-ascii?Q?zAto9iRaWJbhN5Jz7LkQsBJvu9F0iyCvcp3Qp7a0QRCP0s0Cuh0roOdasJ4G?=
 =?us-ascii?Q?OapWH8wKArBoe+IPi77DYgvSDbS1vK4JPz+8W5IzS/xMGeKzy7WkQM40Dx+x?=
 =?us-ascii?Q?LGFjd+s382Rdi1DeVExrvaG31iPWZnhKaEyWNd2lpTU+vQATUnibacC2swCa?=
 =?us-ascii?Q?NzytYkTbV2iC9UERhoC6Ja+PTw4GBdbUXkrNC2nPKQdyWq0JR7hLB2dkfOY8?=
 =?us-ascii?Q?fG8ElphJ8n7ytj4esRFrsETjbpbyzNd8wsU/bj0Z4P6AMXsT12Xo9EiHi2lg?=
 =?us-ascii?Q?i8tGWzwa3Ur74KgH0A5MmAzj+Y0M+I0ykFMfRcfEZbRYdBt5+Cf8KxLjArIF?=
 =?us-ascii?Q?8TLCz7hFL28u2qCT7fNWav2iQ22wXRKhJmgDNndkg9U/RuQVJ2sDdrT4gnAV?=
 =?us-ascii?Q?T3qqYgxnum7L3gLzQiNg9EoMB9A1BzL0vs5BEPqg6Ao90L5zNr4T/V5rb0Nn?=
 =?us-ascii?Q?wCZ1rpoGh2+R2VK3yhwlQ+TpvYPJ5CmrlY8odVMO+WLcMygBHsyniSEKIJ+w?=
 =?us-ascii?Q?jOSuv/gvoTI0ifyGRgwBeHrWX14+TzJa36aQ0XRE75ek5eyIWP82tCu1PA3e?=
 =?us-ascii?Q?1fJV4co9LM6mThBbmpH1uNX5v0BhRJdMi+oWJQcMP/YtFrvZm4StpmS0nG8u?=
 =?us-ascii?Q?1h4TCL11ynx5a/2i1MhH1pV9Ml5fYhJY0Ji2M3bv7ll2PJx2AoOK0eaid1Kq?=
 =?us-ascii?Q?uJevUBJh83qE7Vs263QSHB8cTRd20xESY0cTwGrvwu20mss+slHxD8ODOk/Z?=
 =?us-ascii?Q?pKhSU9o24B+lRvYAd0He+hgl1kGY/oQmyQd+Y5SXVQWK5I/mcqhGGLq1JQ+4?=
 =?us-ascii?Q?x6WK3Sqb7Tuqp/ANXEeyIVfeOdbn6/QWTd5rbESw8ER2DjTBGekYAw72wt+N?=
 =?us-ascii?Q?DwypSkbVCMLhvpCzBYH+fwkSHc2tNaWTj2jPVRBJm6CT1AmzSmiw7/CVj7PX?=
 =?us-ascii?Q?hKeCTUnqyj2sZWO+8II5DoFOnq9hePg+DGXA1DZucbux6VUj0m1nk1B4YsGh?=
 =?us-ascii?Q?R5EleX0dkOasCojKrjoSgKY3NubMj9brg5IeJoRVqO15EQeDd+0DY+3dUruF?=
 =?us-ascii?Q?v/YJO3h/H0aCLqJbjwgiswUmsmpCNhEEOw+nDJkB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ed05ba-cafe-469c-c978-08db422b3e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 05:42:50.1575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bWKkWeAyW1TcJ1bbf7KwbkCHa710MZFn5wJ6ZqaJg1xi+tsFxMpNcucDoNXc0Pa3TK1kWxmvq6VdUe6koX3ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com>
Sent: Friday, April 21, 2023 13:38
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: support psp vbflash sysfs for MP0 13_0_10

[AMD Official Use Only - General]

From: Likun Gao <Likun.Gao@amd.com>

Add support for PSP vbflash sysfs interface with MP0 version v13.0.10.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index a39d4ddf7743..3e900af06c23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3619,6 +3619,7 @@ int amdgpu_psp_sysfs_init(struct amdgpu_device *adev)
        switch (adev->ip_versions[MP0_HWIP][0]) {
        case IP_VERSION(13, 0, 0):
        case IP_VERSION(13, 0, 7):
+       case IP_VERSION(13, 0, 10):
                if (!psp->adev) {
                        psp->adev =3D adev;
                        psp_v13_0_set_psp_funcs(psp);
--
2.34.1
