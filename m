Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA65C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 05:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB6D10F8E5;
	Fri, 29 Apr 2022 05:56:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B829E10F8E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 05:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVnMvZarV36QPUUk2K7ioiyAJvRvIvZB7SLQTtg1pusyn6d7L3d/bejYuMARN7nUcOjnGEjZ4YUFsMN2l2AQkPE1WkhN5kBYgKMneyNCo5PwAhmEpKQe4UZ3O9vf9tY2PPTSUNyjI5Jb8y8Hvz0qLog2scOyipDjPXeSiFbr38/3q4ojUDMTIOiztPmzWSaZVvNGzNxPS1QdJ+iTl0IWgUcGFOBlc6MxWbQvtOVh5hChNp+p0ftoKow/03zINyMld0b9RaPeepXlLtnic2FCsSuUufLaIZPaAXvAQ3tf8p+AohCjUtW2u1pTsXk50XkdUxYJdwfqfyjFTPXa8bZ3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=io5MIca7HnSEpoUf8oiBlbbG8rNaBAI8gN67BfRt/fA=;
 b=b1nKYwyC+qOCZSAbcxJMORt7MjvPUI6KLEc2YDGN/Tku9d7Alhawd8sjpihQHM400KkYUFTIcUmDDnTW7b9We0fjpQ85puhsaxrismnJU52IvJXJba29X06lrA4PhH5kkMK08AhqilN1ZM/As6zzW/lwZ8pmxxJMYLY5rhQdbG6mWMWbvRRChyWwBI1RJDqEG6uobTuF71vrtkkQkWW8Rq2QOtqczAtvNyLIH71OnkLqCRpMqDru9CTuF4LyLfLGAvC5JX8qlls8Qg0V4KRtVkESuLnNdpkKm1plH98mGbOmYJCMd8ygmwyzFDivmGcbiQYQy+wtBZI5PmZJ78dbSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=io5MIca7HnSEpoUf8oiBlbbG8rNaBAI8gN67BfRt/fA=;
 b=rd/uY2jpuQ8vmFikPkHnP57c3XoICkYFZzH067pltpSJDKL+BnlDqsWvq40FjXQbzkjXxyAvY7yuOWCaBHwQ7AYMENRAHLhHiElPsf+5s290nokMiWG32EoOXaa8i1Hh0yN4f4IYuYShzXy5gvgVr4G7qLe45qXWDzFqkoOJLpQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 05:56:30 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 05:56:30 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amd/smu: Increace dpm level count only for smu
 v13.0.2
Thread-Topic: [PATCH V2] drm/amd/smu: Increace dpm level count only for smu
 v13.0.2
Thread-Index: AQHYW38Qyclbftgat0qAJMCD0FAmZ60GRy0wgAAdc9A=
Date: Fri, 29 Apr 2022 05:56:30 +0000
Message-ID: <BN9PR12MB525766CFE187875E7098E9BEFCFC9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220429041008.1834816-1-likun.gao@amd.com>
 <DM4PR12MB5181241E68E377952ADA70A5EFFC9@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5181241E68E377952ADA70A5EFFC9@DM4PR12MB5181.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e70562be-8ce6-4fc3-b736-5c26e19ab960;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-04-29T04:10:39Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 539fea9e-2ad5-4ba4-2dcc-08da29a501cb
x-ms-traffictypediagnostic: MN2PR12MB3933:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3933338A803E14D81CA3D9E0FCFC9@MN2PR12MB3933.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TKEkhPVnUG7UqemqMf2fqDCOZT8Lork1Kb6OHco6VWVxWIi/E/2r6z/1tNGjnuAbGV9WsSSj5S8CtT6NiTiIi8QaQV1Vb21osakIfY7bHwSJqn5FM7c1TlsXKv7NA00nUfaQp5+BfTtDoGZosb3lp0A4fOzkmOt90bvCcsByAf8ah747CHgLRlRdsYtr2MYTZ5Yz0lUvVnSd99DYHRZ+/GBkyLEXW251RWRHanbCsmwJwbEB0dtpIUphzg+WDUW1p8SM/92SVY4mBnCxIp55qNXCunW9N+RD/5i6DNEWb35H14f7yzc5BU2O/vb5iTaUj1KVHWyIOhRsBs7vUFWIaRBu2wuyfvWv9uITgaek+wXDB5WIjXMHGP+SMl2UZ63SRI1m7QpBj4Fem3Cj2zUGrYRrLAyinoke8py3rJvC3RP5xXhMvpsa8dD2AnLA/tcSmSMspveO6ioOnhM5sauVC/sSZ5Gb674x8X4iqshUgv8pBgajWrjMuhdvT+GedY1sm4lPwDAXtEK43YEXhYHgBV/nmdT4Trc/0p2BaabT9+F7msy8UGKeWhrArkEkW4LfQHUan9L7WKEq/FdaFfqDzKA9XAWwJ7S1q09JnQ+JCCFZRHo9VFB6WvZaDhWeM3TzpuOpGnIxsIzDpDGZyDBRmDsRmu8yMkc+BvJPddWV62Py4AP5/CYcc3OdyT+pMnpb4UyzBSZSOHz9+YDyQvuNPYAomG5eh6DmbXitA4kNpxhhx0lSI0vK8ih8uNqRQ4Ye
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(71200400001)(86362001)(53546011)(9686003)(6506007)(122000001)(26005)(38100700002)(38070700005)(316002)(66476007)(76116006)(33656002)(2906002)(55016003)(66946007)(186003)(66556008)(7696005)(5660300002)(8936002)(110136005)(52536014)(4326008)(83380400001)(64756008)(8676002)(66446008)(143363002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QteIkv+uvjQdc0+ym3pS/r/YlxkFLFZuYtcXXmSFbxVnsF2aamzeYrvCNeav?=
 =?us-ascii?Q?lMwf/FDVm6fgvJCUlcaulfX6AkqrZgQ5MjhHPmrwS7gaFweFyqKAVfqNcpz0?=
 =?us-ascii?Q?FDXhtz1THq/RZyg4gFcC/zxKi9JF6kcOqYNY8r6l/swZFT6jMjnveQl4LtjB?=
 =?us-ascii?Q?XwBb921kcKXToVH+dK9RBacictNKJf1EMRQAEqqM3MXE1X9QdtPzEDh6jz1l?=
 =?us-ascii?Q?bqHyfP/8w0oolfIemigpVell87s4I3EPk0Za070dGe5HbhHaQXLTqO2ncYsQ?=
 =?us-ascii?Q?k/QX8eec4dLsHeTqmuZlx6r31hYNVoozrvU852DX8qxnQNKM2Aj53Fgcfg0h?=
 =?us-ascii?Q?9yD0FyDJaGVFsq3GXSryE9wr02IjOQRFoLbC2CMEPywht6h0zotLStqV0f+h?=
 =?us-ascii?Q?jU2255l2S+OvBVSCfl1QYJkgnHH3wlPYdQZ13hgV2A3seEHd61vO7cWB3P61?=
 =?us-ascii?Q?9QNMJ3Qcr2CEKLul9jwrgvqhzbxYPrzBQ50yG8DwacO+e0LGDElYPlpjjlhb?=
 =?us-ascii?Q?r6poWzDjFl4PpM7vJmDBq+QU2Q0BAgPrRyM9wKdq7mOC96VncszmApuMBsvZ?=
 =?us-ascii?Q?Xe9z17G2V1ELwWII2TaYDDQnjWo9KIUUugEqIie7DaCSREF/yQyDmqJ9IMyK?=
 =?us-ascii?Q?JyQp6uZZ2bHTsVk4p6bN4Drxg0syZ3E5dJi75gyqntNeuO7wzn+N1O8JqI2a?=
 =?us-ascii?Q?erDiTF5l7V74E1RsmCjSQjn9wnyk392TdZIzxgeTpuCGX+UyqqwjXpUgVAma?=
 =?us-ascii?Q?BHTr2BX3BhscFjNvATbCnDf/VWedCUETx8hhWAQMtHrxerQVz1/r4yHDdbjA?=
 =?us-ascii?Q?VLxC1+TWJf4aFUOyxIQ1FzFw//ovApTONAqZhmrqSAFpKM3HT1j+4cqrR7pb?=
 =?us-ascii?Q?kWs0j/uJIOHEcXZkIBFbXEx8h3wp8MHTFHQGybQ1nnUuvwCi2QSD7LwY8ciD?=
 =?us-ascii?Q?CfOW6DTOzHUls+gIVl6y93iVOE9/spjPNPlXm3iMQg4KlcaJaUlOXoWt5/pQ?=
 =?us-ascii?Q?WygQqO5WxbpNSb4n43txhGSIs0klA+MGOy8yZoHEksQpDl2sPzP62D+mJzsc?=
 =?us-ascii?Q?Ysi0Eg14yVZJYzHOpeXYkl6KvB61+b+VijvV122p2RI1e4mhXsGNyAcFt1vI?=
 =?us-ascii?Q?dlqrRo1dUGyKfo2LqGKYBTrmQzvfbkn2QrsTwKxQ7zDOAKX7CBkbnC4oN1bO?=
 =?us-ascii?Q?1oEGdvNkv7UcpA0QmR9CaQbQIKpEEFCtw8QUc7Sd9lJq2o8inKmgn28K3iiN?=
 =?us-ascii?Q?/q5K3aaS4FnPNp6ujheTnqfqepwQ4LUUMUWwj8ZYLrrvDj3pYB2zGOXy8wal?=
 =?us-ascii?Q?Qi0c3FvnlrGqqUNnRWtL+dVr0MVwW1CHa24fPMDXIk0PJE8bPLBJ7CU6RCaS?=
 =?us-ascii?Q?AkaL2RflTFNO396PFdcCyiiKJEgv6ciwj/K3Y8Or86a/vmfDoyDzki9t+e1E?=
 =?us-ascii?Q?xMkimhgZlMxpLlnAGQHEPPpNlK366nk350n5Jb2P1Yb3uGPMMi2LnVyGSlVr?=
 =?us-ascii?Q?A3bLMHw+/Pljf/78X0ZYKOd4Ps5j3L/i8KpWY/3aWLJuWHFwWEhC1uWFG8A4?=
 =?us-ascii?Q?lsC2NziXJ4HjLZVwqZVVfzYRdHenfgRE85uEiu00r/8u2BfiIHUuZnXSUG6X?=
 =?us-ascii?Q?8NmLg03NXpTSihCvRg2tFuoN5mS8hiBTH9asC1xKgIE+MwPI1bAQ8eFV/eI4?=
 =?us-ascii?Q?1SyhXHzSVb8CNL8XaGjsV0VTFOHVOGLfV7COHtNqkBg49uTsZXGOWbk84ogx?=
 =?us-ascii?Q?sdRs6F+nKw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539fea9e-2ad5-4ba4-2dcc-08da29a501cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 05:56:30.2626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c0OhhG3fXTKuJJtS5CzSXrb6HSM8hjnPh01LMCw+lJbMGy33w3rr0E87+3h5yjGwoREqAxZBL/PB6CWo6y01nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3933
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com>
Sent: Friday, April 29, 2022 12:13
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH V2] drm/amd/smu: Increace dpm level count only for smu v13.=
0.2

[AMD Official Use Only - General]

From: Likun Gao <Likun.Gao@amd.com>

Only V13.0.2 on SMU v13 will get 0 based max level from fw and increment by=
 one, other ASIC will not need for this.
V2: replace the asic_type check with ip versioning check.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index cf09e30bdfe0..e0514ce3ee57 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1750,8 +1750,8 @@ int smu_v13_0_get_dpm_level_count(struct smu_context =
*smu,
        int ret;

        ret =3D smu_v13_0_get_dpm_freq_by_index(smu, clk_type, 0xff, value)=
;
-       /* FW returns 0 based max level, increment by one */
-       if (!ret && value)
+       /* SMU v13.0.2 FW returns 0 based max level, increment by one for i=
t */
+       if((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2)=
)
+&& (!ret && value))
                ++(*value);

        return ret;
--
2.25.1


