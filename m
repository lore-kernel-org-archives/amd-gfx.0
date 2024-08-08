Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C840C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 07:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE8610E673;
	Thu,  8 Aug 2024 07:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BXHa49bz";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C518F10E629
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 01:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvefRNcGNFNYhxySI7pXn0TxAJxv3x86OVlfT4O6QA2jNGm8Vz/8dbQ3kaPph5e5j6DdQqeuhCO7l8IcKbLaXipOxJ/WHc6oBRnCzZ8nWbv6YwR3sSPkqAook7aAUor2hqr6X8wGKwudS+7vcWHrhQGyl3f74lZaSqiblKGyaWm9p9nWidcSpVqEzwnlpKRKlzk2WF3LzqK0d2VUvgkq7usk34nVdSeMB/vsyC1k+WnA/f+bw1emW4uUFMpIA+7OoiYkuc8k/RJMH4+dQgkirUFFfUqcNBWwWd8IUeLRx0oVmhQ8R97eoxEZdi4Kozgex27/cy7xls/5Ugw1b71/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmwEVI0durHkgj++IIIjMKRiysd91wU0wD4+P0GQ51M=;
 b=KNBkIQM9bEAAQ8eQ8xq/jt+HhCz1p8ILIlp3EiRoYmjuxXqytX00zp1NUdfN8pk/1MSbvoViXE469d4NQ4ghx5HW6jxB2xT0CCgtyFP5NwRd0vBwYHOje5/FhZigAyVhLDSYH04kJxc/8AKgULB4XL0I/CYHTT2ysAhZE4oa4snZPZ5+pokS7HU3PhEnu+kkKv8WBwqdY6AG1NfKMgtROrcuSEr8aVfZ+BMMYaNANbMDF7nZY2/PCBGNd3LV60pzlRZpgIdVL7r7Ay0FVWWLTkD7xeBLwamhARdLCbtnC4qMbQHwKarmFA8Z5Y8bVPE2TrpgdyX1nuEEYG7plNnCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmwEVI0durHkgj++IIIjMKRiysd91wU0wD4+P0GQ51M=;
 b=BXHa49bznX2s4Ykg0bHs/P6f+yf0I2O+TLv54WSEJaORoPzwZ7wzxOTEuqa18pRHXShNTDrK+QXWzLvnc6G4M+LiXh0FSGo5TIcAESJ5sb1fPPaD+bkPXdBnG1E3lmG/JTUtKBLVYjFTypOSI+ngiMLGPyVLZBDutV5yJFQFm5c=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA3PR12MB7951.namprd12.prod.outlook.com (2603:10b6:806:318::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 8 Aug
 2024 01:41:05 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 01:41:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, brahma_sw_dev <brahma_sw_dev@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Add node_id to location_id generically
Thread-Topic: [PATCH] drm/amdkfd: Add node_id to location_id generically
Thread-Index: AQHa6OU/GDkcuBiFG0y93zrY/GNOQbIcliBw
Date: Thu, 8 Aug 2024 01:41:04 +0000
Message-ID: <BN9PR12MB52570FDE4E4369B0AFA055FEFCB92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240807161638.1647935-1-lijo.lazar@amd.com>
In-Reply-To: <20240807161638.1647935-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=de4e3b97-4a60-4cfe-9a00-bcf5258696d1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-08T01:40:32Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA3PR12MB7951:EE_
x-ms-office365-filtering-correlation-id: 1b511f5e-f0bb-4e8a-36b5-08dcb74b2ae9
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wVUqVAqP3xF+1CeyG3krpzCDCUOFpSyY3yvYC3BLWYsXZMiwKR+7qq9id3nO?=
 =?us-ascii?Q?21aeUldEir45BG5lE2mbn+UEx6UxMSQ96HJdcPmlzjRNDCR3mhX57JnlH/IY?=
 =?us-ascii?Q?UIGDDWpRCp4EKfWW1c8WyIztaGOzJrJVPL20kyJ3zHCc5oLegZtu0WTWkqdW?=
 =?us-ascii?Q?B6eT1H0ltPEv3/lpU89C+3tNhVOnEnat6FnQnIF1QXzsFgLSYyhFvcRv8opV?=
 =?us-ascii?Q?wKsojMWe3cPRi38YwA7CIeFhTwaUn47IuY48Prg7d+BtJhWhdhjgrtTsNqvm?=
 =?us-ascii?Q?f/1bpJW14fByppOidPszKk+BKDX1Y+qyd0faIgKoQx4Y8zdT6+KbeFDYYgIv?=
 =?us-ascii?Q?Cy3SGGsfMu6HRXDIMDeCjr4uqW+VOVk36n3s4wQROdRCXlxQfwei/o1oK8DS?=
 =?us-ascii?Q?VSJcnXM7wd4PJj88AEn3Smm7o/am90KT6Gr6SWiK69D5yDmToP/BeaCXa+TF?=
 =?us-ascii?Q?BQDFcRR2YsasQqPDyAlDg7AzEOMig0Ei0VUeVgKgTanRhDjxnP+1kln6DBB/?=
 =?us-ascii?Q?byDIzdIoV1X2WpgLz84MzPNcvwSuufIDPgVroY1VMolz1Rs1Cd6LK6fd6xVR?=
 =?us-ascii?Q?OxgVkfDZKWSiKB3wG9kGzbNw/L+gFe1PcSlacCrAhwsxJ1Dcaq2eggAmGJn6?=
 =?us-ascii?Q?mlF9YowmqrQ7mWX0dP7gtFcehrt02Wc8eYIWYxgkG9sKslVyRsdPXudaDvUe?=
 =?us-ascii?Q?wQrHX06V/e7r9zS+x80FP5uzlamcKOUqNmFOWe4eDPn5wFBUFy9mbhxJFwpl?=
 =?us-ascii?Q?ZTuwFMjd+yZNA8QaSd/QnTz2XqL7vJMten9k9Lb6rh6RQNDR4jH7JUkpU6vV?=
 =?us-ascii?Q?eQa8ZoKMgTAgx0CxWGEWrsEYuxwkh0xLhXy0yPw+wWC7DMyIgIMmtrjqIko4?=
 =?us-ascii?Q?Uk0oPpesOPJRcjxJOjpNsxmUUIw+MzPBWOQI7pqXjbEZ3hWE4Tf/zK3xRRt4?=
 =?us-ascii?Q?7Tmk6Yg9VLzG1aXj/jJGd47SPDCQTuxLWCeuNEvA7LkA75wLbev1k5jLOTRx?=
 =?us-ascii?Q?/ZvHIXFy+bhdSZGuFnQX6DHxffV79mLql/tI9WqF1khWZqu3FPWWVQAVx8RQ?=
 =?us-ascii?Q?2lGuO7zMiVsaEyntEL65jqBbhpMyWhljG0dpONlH1w74LZNiW3St9V/djwxN?=
 =?us-ascii?Q?JR6375ROHIZ5Bo1km6gg3I1gXyjIJgftH7p6jMjiFpCUf+IVGlgWVG8KWzMm?=
 =?us-ascii?Q?opYXv4/93dvFjkLVMJplDSnZhtQj7xrutRDeOkjOmcx5ObJcvDeJiQtPEBHB?=
 =?us-ascii?Q?UkSU5yR8ysdoe6NQjsQHPC5+tNrEAaWBaOdJzkOzCcLR7hyrcAJBy7mXwZ7Q?=
 =?us-ascii?Q?2Pk2We497aFz4iKCDsn03/TCZG8hHpfk4uk+AVcuqysSRWLxmSl0m/IiLyRb?=
 =?us-ascii?Q?tb4rDjnhNybkH0tUzU9yPA6b0wd1ypoF8FFc3IgDWc9PM9y8Qg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QEzUWj9Shi4cuokf5oOhjYW3wNlhkS/LpoKGuiBvsY71n2/hlUcARDQWsEuI?=
 =?us-ascii?Q?6B/W06WKrqQ7VJQqmqTcJWnXBhUByyDnkrEMebtD5QfPXhboR7YFq69qkTBz?=
 =?us-ascii?Q?0pJ+IJ1dAln3TaiRPkh6kBKnNI33Huwb9BFI5/rDE/RobWB70WYjgZhbraNF?=
 =?us-ascii?Q?RHdDxFsjy1wWFxdHwfMjobHWeuIteN7e336pympSFn1j+MNDDVmO217y8rQj?=
 =?us-ascii?Q?jqaCODY8/g0/eXmynNTh6k58yf4lymxzgMasFlnxlXCPyY6N0U5jPBmaKif/?=
 =?us-ascii?Q?/RKufQI9IIDzXn+YvGbHWCDh6toC+nFBLjxLq7sSKjhMLEhn/2vExmlQp+q2?=
 =?us-ascii?Q?NJAVBBBnOXSyzRT19bkHdKk1Z8hxpoUit6Z1M3Stg1hUZPUAzwsoa2kmU07w?=
 =?us-ascii?Q?H+K9gESgbiyMy1k9CoBbOqsSRQEw8EVZBol0n8NKvAEflQywQ33H0LkSmy3k?=
 =?us-ascii?Q?TabSDPRHlDy7hP/OkSD734e4MwswoNbM5elF0r30Jum8Oou9n5sdNQobrP1z?=
 =?us-ascii?Q?UzBEGODYo7PzR3I9QUU6h86bPre4EWYZOh371mYCad0E0/a51aidvMSo0pC8?=
 =?us-ascii?Q?wVjDI6XsWjcHAUzF8OdKjdRzcv0U1VG/LkrIKJtPzj5f9kvm142nRhctsWjz?=
 =?us-ascii?Q?NdWChHUpjodCwcXFd10uMnhNRmxk2t3VADFjhiP1cS1BX2gLLtO6QhzLpXQ4?=
 =?us-ascii?Q?PwmcVNJfpdsGHUX7QBKto5mYGzQvM6BWQSo+fX+H6jQiERg4KT93gep0OmDT?=
 =?us-ascii?Q?d6UP089cMvolaQgmw7WyE36sT0g//Mnazt3IA0FeQQxrELUIC5Xb4uoojDhe?=
 =?us-ascii?Q?lLIxKC4zkIIGh7NfL1wkWbwOR5rJdbjEoWNvzZ61lsefdx9sEOXXKrzB8McG?=
 =?us-ascii?Q?CjezuW2EZ6wtyoFv6FWS4yyyV5FQtxi6hifsRv6kcWPk5FEej0I9oFzf1V9R?=
 =?us-ascii?Q?z9V/6HmtSOAivpDsKtwdPwJ+Usm52p1qfKCE5BEdkquZpHL8+sJQK+1vrR1M?=
 =?us-ascii?Q?AOFnpXxIq94BZ4CLVBOhNJcV2TzJ/UKIUOM+tgG1uaKxwqZMvo0Bqc/LxwL3?=
 =?us-ascii?Q?olwjhQU6cIiKBO/ZSknJHhiXJoO4fYl9mGE4mvI+O2kN1cpCu3qPpdPp+upK?=
 =?us-ascii?Q?46NAYPAm81UILXE0gcnTbQCmxTsmZ04bVi0DBaqda4AvmWMFOVZdXH8hOfv8?=
 =?us-ascii?Q?k7xAy5vP7CDgvkm97ngcJvrRiG3LC3+CiJ2sMXppQldhftcsFaHFX+x7Y5UD?=
 =?us-ascii?Q?AYm1jVlr6OFhAUDVwVfwrrZUnRy6CIOw1LXYhfx9L4UFdxAtIDcx86FTM7mU?=
 =?us-ascii?Q?U2m3xRIPpF+84QCeYKLKa+4cjdo48yP1xbcZpWRumF1n0E/9xPjBYUzFDOyP?=
 =?us-ascii?Q?P40b/qTp587MXccSKxly9S+l18FgYG5puBRZvjhVotj/ljrjYcHzmXgXeJSh?=
 =?us-ascii?Q?Xs9AxdQ8FmlyExV4RsyiulZRJ6wBPgnbFuVI/46zXFw8ZCp1F0fXNDDo2/8i?=
 =?us-ascii?Q?wbNrAoDHUajyoVRg3fwWPRm32ey6cxmq0LCTdV2UTDQRjGd6u++5W6QuCCjd?=
 =?us-ascii?Q?W0PLcHgZWtOCNPZs/uSUyWAuzTR0QwunSRdNusq7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b511f5e-f0bb-4e8a-36b5-08dcb74b2ae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 01:41:04.9611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZJJO/pCnoeKTIhS47ogFCHCvgeezdJTVmkRKJ1e20YzXZWkqDTUqJtO3T6pz7yJw/Ghmg4DPOdV61durR/40A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7951
X-Mailman-Approved-At: Thu, 08 Aug 2024 07:17:02 +0000
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, August 8, 2024 00:17
To: amd-gfx@lists.freedesktop.org; brahma_sw_dev <brahma_sw_dev@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Kasiviswanathan, Har=
ish <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdkfd: Add node_id to location_id generically

If there are multiple nodes per kfd device, add nodeid to location_id to di=
fferentiate.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 40771f8752cb..e6caab75e863 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2079,7 +2079,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
                        HSA_CAP_ASIC_REVISION_MASK);

        dev->node_props.location_id =3D pci_dev_id(gpu->adev->pdev);
-       if (KFD_GC_VERSION(dev->gpu->kfd) =3D=3D IP_VERSION(9, 4, 3))
+       if (gpu->kfd->num_nodes > 1)
                dev->node_props.location_id |=3D dev->gpu->node_id;

        dev->node_props.domain =3D pci_domain_nr(gpu->adev->pdev->bus);
--
2.25.1

