Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37049EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 05:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E327510E0D1;
	Wed, 14 Jun 2023 05:06:08 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6AD10E0D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 05:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOCkRgYfVn5jHSHEWBtYFRbjHQ7U6fxWq3zzHe7I1Rqff+4yRLRmgilPXcQTfyeWDbMftWuKuWAai7reLrGN7ibFhiqSsbjgas161Z8VkkaL77wJbB6yGYB6RDH9e2CgQOKafBbmCqVkqgTW+5qoZilgFBuDpgdJCfa4M5EbmxBZDohptL9/RzHpqNx0+QwwNg0mXSWhbhbbZnl++2Ulbl6f0h+EBbjf2RK5gARrEpN2QZJVcr95vnDcglqltyI/gNCwR+HTVFhFdnv69PsXnnH3q6GE+mIM0XzUCin+l3vxQGupJec1NXqxqd9soXbCDD9xXPLyr+qPjUrK/oxC4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZtafzoJ/eLNI/dfQvxM0XsvNoerfzr2T615ac6o2KQ=;
 b=LEi/rq/aUMubQJPbRi9MAxexEK41ghz1YZEOIj4qQTf7Y4ZsLNFrHhCNu8KJ51dd36n2btHP8dt+p2UW1Svo9d5zHm5Q5HS3IbkWCBmbsx6VkPHDVS4zqreqsp9SDjQqkcpSKvk/cXbOoMSCQ3CGG0ChM15gcyrtIcajSU1aTxfLBVC2ahXE9SWnM4+i1NWsoAlvtkwTSbZBZgKG3ADRMjKjHUez9Vj2ULE4MXIs4H4MOsnoACQ8+kRIvUo2t5y8eXRURHSul1slGVrAAupa1bM/3DSe0uii5o1dJA3HQSfJ3TcfqzG6+InSoITxF8dK6fBE/8XY41YyWr5+2vk4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZtafzoJ/eLNI/dfQvxM0XsvNoerfzr2T615ac6o2KQ=;
 b=WP3Aek4Zmdokz3caiwj5nuYzB31zBGUpzUgfPqdIuqKhHDbteV8K4phocQF/HIFwpazauqstO3v+AnFgiEKxHPdVIpdwIy9lFzVdc3vjkm0WeZUAPtHnpj9iYY1maTfX1QoXQfCBfVu3vyDyxmrSPRJ6DFfYWeS3+aZKDWIsems=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 05:06:03 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%5]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 05:06:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Move calculation of xcp per memory node
Thread-Topic: [PATCH] drm/amdgpu: Move calculation of xcp per memory node
Thread-Index: AQHZnnifmP9sh32NQ0mfqz450pETrq+Jvs+g
Date: Wed, 14 Jun 2023 05:06:02 +0000
Message-ID: <BN9PR12MB5257285944DE463884546639FC5AA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230614042748.1588642-1-lijo.lazar@amd.com>
In-Reply-To: <20230614042748.1588642-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4074e388-9f76-44da-be83-9694d711beea;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-14T05:05:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW3PR12MB4492:EE_
x-ms-office365-filtering-correlation-id: 175b9b86-16db-467f-2ebb-08db6c950d23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uXC9TZ/FRvVuCJYyiMRgk5l9O5K0voIWxBQauQpCVzuwGnCNDRaesuXq3e70TAEigbh4rt+6YE7Eqzu8cPnfYZds7zDrW9wAbohG3TnfSUbQGOcGKNl2dEMR/dr9lbfR4IMviyjFxKUszZiSQKHs/WJGos6+Sv5OpYgQ1NEKw5+K8oMxXdhTTBHmS2vtKyq5DzeZx5S2wtEcmMdDtrMneyE0AwDq4a/WKfnK33te9NXYGTvzJpMQ7YsM982yoMzE0oNRRLz9euzLyLkhywvjnCIUB2rr4/bMK48/8DPWsPFET6B6Frd7DYG8t02xaQa3gZOfFwO5ApBYTUFLbQagoUe0/qTogYK01LA2zqNiviuJTdtT1DIGLYICLJ7WvE3mlR1opXnoJMWwcwapoVHA8molzApQ4Z0skmtArbK57GhDo8+4z0CFxMuaK86Lidsw+VOh++Z23sPuif6RIXNFJQ1A5tCRxUQKXGLSyvngomB3zDWPWCAmDVXVcjkh4GYDBwzGHQ/eNeRax9ihh3Wn04LYOgJ2SmtlQn6dyfFDUsRC+6eNRMUt/0LMr7pn8SYC7K0uHwAFsLFue0CiVNQg0kKD4Q67UfBCgky96ii5IXBM+xWNBvwgbouvEwjWAqI1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199021)(83380400001)(478600001)(33656002)(38070700005)(122000001)(55016003)(86362001)(38100700002)(110136005)(54906003)(71200400001)(4326008)(7696005)(2906002)(8676002)(8936002)(5660300002)(52536014)(66476007)(64756008)(66446008)(66556008)(66946007)(76116006)(41300700001)(316002)(53546011)(186003)(6506007)(9686003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6vRDWDX7Tt0OI63CiyzVepDK9f0edRbRTTDj2tHmsJT3P4jotaS4vWy+8KyA?=
 =?us-ascii?Q?HsgHWR7lX3Fj4Acx61MqmaDuRJHdfoGlFaeLTUAvS01SC+czrQGGebxudTLA?=
 =?us-ascii?Q?in1FvjDYLJGMlQ+jwOrd/vCtRUPMyYhbtAiywgH6SW+F7xviaoY02bMit/Z5?=
 =?us-ascii?Q?MdLZOpI1WIEjvtgzE3zc3cW1r0+aZYzrHLHeTKDwuhLiVDufsV1v+OWogaiC?=
 =?us-ascii?Q?iden4JPyfXXHdK+bduVT97ueN//mGSuFtOd5mYDfZrmb+qiM3WHmHO2H4VKN?=
 =?us-ascii?Q?F9ZQoD5EuB9yI1z+1mxxkh/5UEvdx97oHrTgcUj2I6rl4CkEDSUuCjjBSHiK?=
 =?us-ascii?Q?3/gz5DVIC+g5gBmS9pRynqVHm/6C13WOqmTITA6p6HlsMWteZCFlNBDLvYpq?=
 =?us-ascii?Q?RuEAiU7yTX913uyWuCPbvfHiANA7IyZ/8OySwnqfcZpXv3F6rqmjPNZxHesO?=
 =?us-ascii?Q?hKlx81Fet8wazeBYbmOmJwapThVhANxJ6oB1tc24ppRlNPyf0Fq7BmEiEhNn?=
 =?us-ascii?Q?jYnSYbLNRYcvd1FUmhC656IuU0VzY5SSDGzYfawbF6jLCNFleY4XhhrnX66w?=
 =?us-ascii?Q?dBpa6xTaq/xM/nIUJuxxv4O+6e3OrL1g+ikE8E8EJeHFYpRNa2F9NIm9BRPw?=
 =?us-ascii?Q?eVMp5QhLjdk7NuLk1HcOEqMBNdxRIWPZUCADnQ4/BNCSarMw3amjHIZ5qp6s?=
 =?us-ascii?Q?moHuMJRPfQVaEF68Kuz2KgHJuEmn8AaaftWHN0DjSsPUfqQQEKvWUJe5wrTq?=
 =?us-ascii?Q?6wtGoI7NU7u8KocVzER7okOaMYD/EkJk5ixLQEW8XN7IWCwEFrKoGVVGwAVq?=
 =?us-ascii?Q?3eX4QqhZbJXyS8HH93ijljPm6McU+RN5B8H5xPyTjhlcg3UhGpQrlHTVyPeV?=
 =?us-ascii?Q?Jrj9CuRq9LrH1xnUscO7M04pnobm2a9G+ZyLwR8GxeBNkcJKY0B3YUOYBVed?=
 =?us-ascii?Q?7qJ2jEKjbrctV0t2upS4VJy/B8/5YYQFaBzINI0ikXkzjWrGUSVyv04YSZTU?=
 =?us-ascii?Q?+V70KIckF2NtJPqTuHdg8v7USUpFkwTWLEBx3kGGkE/ZHg4/pucRN2m41ajW?=
 =?us-ascii?Q?kWA4EDiG6TKs4m///tbgg8w1pkESl/HelSgiU/aF+6/V/vJbvD/QvAni5Rd1?=
 =?us-ascii?Q?bUu3g6cXDFwdh4CE4+Jp9SBcHhjClk7+yhPTalVDMi/1SFK5SysvYdEMaXIP?=
 =?us-ascii?Q?SDPzxJUs+uFHs+TUbMuVQlJ7iO1bYsoRwMv+wzBvCKJdp+a3NzcG4M2zNbKT?=
 =?us-ascii?Q?ose7bNexKYZ+nFi1m/9bcvRAaoORReyyBBoGsjjUZNxi+FnxR1FjIST7TomZ?=
 =?us-ascii?Q?9KBGBMP2hylmtaWlea0Era52Or5mK1FauzwzHw9YrcvrikpZsQRb8nK41EdB?=
 =?us-ascii?Q?3XY1YHEyen4qfpeknT4Ppob8n+0GI2QaguJvXqIiaoEYbLV2QReE+SWK/pZD?=
 =?us-ascii?Q?odGUmAeOh6sxqDY3V8h6H/mksT/zq4Uk8hY3EGG8HRm2rLQqzMC8gl6XQy9v?=
 =?us-ascii?Q?V0ZWtWrXjeDf4GLCfwt46/vUKQBIHbFFSLxd4HTZBzlOkb51CxMVV8MPeV5l?=
 =?us-ascii?Q?uZTl92T9Tup2A84/NNLNJmbyFjf0xqyOxtZna4CI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175b9b86-16db-467f-2ebb-08db6c950d23
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 05:06:02.9350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBzfuYeQu8EMLEximr73HFuCoou2iwI1yD3c22pb6c2st9rTkK4kYzshEwTo4wxgy1/MNYJdFzBDi5xt9ps5aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, "Ma,
 Le" <Le.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, June 14, 2023 12:28
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Yang, Philip <Philip.Yang@amd.com>; Kamal, Asad <Asad.Kama=
l@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Move calculation of xcp per memory node

Its value is required for finding the memory id of xcp.

Fixes: 2130f4ca70b7f ("drm/amdgpu: Add xcp manager num_xcp_per_mem_partitio=
n")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_xcp.c
index d733fa6e7477..9687df9841ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -132,6 +132,9 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int=
 num_xcps, int mode)
        for (i =3D 0; i < MAX_XCP; ++i)
                xcp_mgr->xcp[i].valid =3D false;

+       /* This is needed for figuring out memory id of xcp */
+       xcp_mgr->num_xcp_per_mem_partition =3D num_xcps /
+xcp_mgr->adev->gmc.num_mem_partitions;
+
        for (i =3D 0; i < num_xcps; ++i) {
                for (j =3D AMDGPU_XCP_GFXHUB; j < AMDGPU_XCP_MAX_BLOCKS; ++=
j) {
                        ret =3D xcp_mgr->funcs->get_ip_details(xcp_mgr, i, =
j, @@ -157,7 +160,6 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, =
int num_xcps, int mode)
        xcp_mgr->num_xcps =3D num_xcps;
        amdgpu_xcp_update_partition_sched_list(adev);

-       xcp_mgr->num_xcp_per_mem_partition =3D num_xcps / xcp_mgr->adev->gm=
c.num_mem_partitions;
        return 0;
 }

--
2.25.1

