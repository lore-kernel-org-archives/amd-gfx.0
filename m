Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CC5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 08:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F388689E11;
	Tue, 15 Feb 2022 08:58:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B80C589E11
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 08:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7Vpnt1QxmqUn2hqfuAbwkla5TgBudbeoy1kcaOAsHRzHk4RaxwiKGLXMPauRYXiNpNrOY+hpYp+Q+4/WpM70mU70BEX/MNUbJrvkKfRH5RJESUywkIqLym6+pIk8uXgosyl1YELTLpDODbGVyZVBSfRcTA0sGbBqNBlGVB3wDDOem7AnSg6hWSjPnRBauRUMQf3YBxeN3dY3HqhKDXJEPZJgPVw3GgWhhAGXYdCLpILKymhsIHlfLKJZKhmTFSWUYQNd8itz52fYPeW2saVi4jKguHpZYf56U0OZ0oy8R6ney4lCniri0vD0MvPpNaQj8BPYD4yewSe5ytgLi4fQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFB5pO8kJJpQI9PG7BWEH/rNn170taUW4X6ibYLIdFE=;
 b=Fu7lLTfNYXMV2kaLMcCg+YyZqo024iQelBgpv3iUqPb3Z2d/AN+G0iAKtSnMfsyEMo5oaReKHWQkeoeA+DZ8WmTse7B32rkt+VN6lManbU6xEok6C4RBa7DwPEUXNWiXRQQOFms3YVrfgD24VmqVPRUa75J78GHtWzEEx3o7Nx5SvmX9HrfBLE8Uo6mz5nTimGUf4Ha4/7al9FHsP5mjGMMPdROIsiixjk7skZAJYwQCy9QtqNadRl1R5sH7QXRs9jNehlzDFM+RSdADmqqEYR3qvg1bcO59mB4+TLlMW93L2VSwjQhvN4yO3U7Dfe5B0bWEg7KI7CfyFIAE/0P/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFB5pO8kJJpQI9PG7BWEH/rNn170taUW4X6ibYLIdFE=;
 b=2vTOPnkg+HBW8nbiA1WV3UBPzNtCU38Chzz4at/0zwKBp7i3zFOd3oss879RSgXiaR6ikdIPvp9P/WZu0q7p2qr8Yz0y9cLtW33B4wT+CtTlmuxEOUqrDRypflbIT0Y8cLHnwzS8vHmvY5nMSqA64z+hL1hpqQizTXHirZD0RzQ=
Received: from BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Tue, 15 Feb
 2022 08:58:05 +0000
Received: from BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::fc44:f9f3:62e7:af2d]) by BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::fc44:f9f3:62e7:af2d%6]) with mapi id 15.20.4975.015; Tue, 15 Feb 2022
 08:58:04 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add "harvest" to IP discovery sysfs
Thread-Topic: [PATCH] drm/amdgpu: Add "harvest" to IP discovery sysfs
Thread-Index: AQHYIflLplWhXFwF9kOo2y9RgIu5RayTr1sAgACf5oA=
Date: Tue, 15 Feb 2022 08:58:04 +0000
Message-ID: <BL0PR12MB24653E696EE8C9F3E635AC7BF1349@BL0PR12MB2465.namprd12.prod.outlook.com>
References: <20220214231857.5129-1-luben.tuikov@amd.com>
 <20220214232154.6421-1-luben.tuikov@amd.com>
In-Reply-To: <20220214232154.6421-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-15T08:54:16Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=32d6e710-696a-46d6-b21b-29b04505e493;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-15T08:58:01Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 5ba1fd0b-6aa1-4046-b0af-0489dfec128c
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e84dc514-7f15-432f-d11c-08d9f061475f
x-ms-traffictypediagnostic: DM6PR12MB4513:EE_
x-microsoft-antispam-prvs: <DM6PR12MB451367FE6D5682C84185F60CF1349@DM6PR12MB4513.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:381;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DUCC3jTWRJSQQ6UbcW2KQZ2XV62Gec9WdNdREA8/cr+hIqgolpG21Nh8JB9g6VQRE7MZf7JqkL2AN0odn4XUaarr/w8iXFmRDJqHc6RKO2CDVYxZIKjsxqq2tU5DfKD7S5AposRipRa0+ftkeXynMWOJECdmZ9e2AHyAhHC/bJJQPa8S5iOnBHmxQl/X1dmHokF0CiX4HxtIpibtmJGVIsEMLR4+Z1mcrntBSOOKqf8bEfvQy9yOyK+8Jl9iWwxEjm48tWYV8+QDuyY+WEJMQmamJ3hUHvtmb2ZxBzaw84W7HjfLq/C/8MqpyOMsl3lUC07wcqNpY7gnO1xdgx6h6EiXRa+bySpaKg7RM7FUnCXluDmKZ2O2twlqKFS7oH4lCJgiPtMg9VmJacGAtkO+eAXx5TBgvwSa3BcYJZYImTU1kQ8oFQ2MXjjSHAmedSzhuwy1LfUCcg+jvOpRKGqPqqSe3I825KxchcdM4pZMa1cag8chvsIXCCeQMbqc3GzKgkOIJou/hvGEOzV2hgDcE9qAzGgxb5uw/7QHLbEHSamavKfjrTn+3cfXI/q9X3PdNBqd3EhGXP9O1ta6cL04TPFjiOxRz4WFqvHjYqJzB/W5uYzcu1MW8+0if45TkU4/6SY2XTnU5ZhGH3yOnj6+hG3EIeMtDqXxSnWWLEMkqdpt8jLWc07G/I1v20LE8N/O2+Xo1jw2hIdysyohhc2ubQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2465.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(4326008)(38070700005)(83380400001)(186003)(2906002)(33656002)(55016003)(52536014)(5660300002)(8936002)(66446008)(64756008)(66946007)(6506007)(7696005)(9686003)(76116006)(8676002)(66556008)(26005)(53546011)(122000001)(508600001)(86362001)(316002)(110136005)(66476007)(71200400001)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nBSSnLcLV0e1SUifxDJWdjdeGzLAjAu9TMdsyV33H18gz0AADpszSythcHja?=
 =?us-ascii?Q?FVBF8v9NAV2LmWIm5w0cD0rEkboi6In8W7BQ4AJQ0Tpzz3Sx0hKeUdyK0vjE?=
 =?us-ascii?Q?7on0debA2LYnScxo7gj5m32gb0mfW6EHh7jqVkvsn5g1nQZGyoG8xYhqh5e9?=
 =?us-ascii?Q?WLGtG4zDU0fQlYNJlHq8axdV/zcVxVTm3hn0br+DTEAucFeNLEocuZz6rOua?=
 =?us-ascii?Q?rEVnLMV9+1MLTwXnSRgtXHA/CsJ3zKz9lpQHXJ7Luu97m66zhoTNeg6KWSpy?=
 =?us-ascii?Q?19zjxTDDOEniTJ5KlFLIV5Eixzwp3iCgXPRI04v9eYWJlUHqGeumVAUfWMPK?=
 =?us-ascii?Q?Lki78UzF1sU1kTUBWv9tJ4KB1iKPBej0QxEE6RJOwtvMdqyIT/T0oe4RM+Gt?=
 =?us-ascii?Q?VQ+m1bBgLyr791k2b5gK6DZmIfMzbuE3YNTAo309m3vikYZkVF8atuVfLUa9?=
 =?us-ascii?Q?z/bXDriehrR9gyBlRy5snjRIpR3j5Kq0C1w8awjt2LBSPd+itb7WA+VcdaKq?=
 =?us-ascii?Q?oBNVTR86nMWdvZvulV3CGWHGhM33fsDe/g2bXS2Orowh8StkozPMd/fGyuqJ?=
 =?us-ascii?Q?q9ysLFTAssWgHmAHjalDp9HpvzrTmPbB4yUtC978iPwN5WIp0tLlw7hc8lJm?=
 =?us-ascii?Q?sBnTHPzHqOjAjLlwbTq8C//DzhP3O/rfrayWXOU49rZuO2CUcfSPtXaSBS7C?=
 =?us-ascii?Q?hnP6IEZOm/Om1umbyZDKIhxUeZ1yxoMtuplp/dymYZbCqgn1710aNhv8UksG?=
 =?us-ascii?Q?9SRbrl5uSS+ZA4WmFRaAsWTKXKgXeNchMv7eU7K301vHtqqj7rJcL/DXwPkr?=
 =?us-ascii?Q?RH+1N3s45LLgqxhcCwMUnb9WZrM/Z47lVKwH6rvnqltKyxt+/kRXa9FWs0zg?=
 =?us-ascii?Q?ovhoZNsZvd55xUUdVyEZNGYTkhv0mMNf9ZZ9oqDqgsLbAN+E1ZN6b7t765Zb?=
 =?us-ascii?Q?tFre3122ZnaQpOjVXDQaCsvl4VZyxcVSjhbHqDHQTf9Yp/shE/nLnFYrWQSt?=
 =?us-ascii?Q?OODQpqd3OVuzA9JdKuQjLUikUedyNCHUA/fLLHrbLjCyDd9Sxgxhh4RB6fxk?=
 =?us-ascii?Q?/nmu6B8T5gAYd+TgxXcqDkXrQ9Fq2j89PztyBQLkDlxSNdOVFu3GL9481DKY?=
 =?us-ascii?Q?bkMY+ilWyGjWvnZiulhmPXDuIjCOdXwo0WO9zfV3a9Zuq0d1QgFtXSrXqBpU?=
 =?us-ascii?Q?YnW9Y4BJl8QiAaZOP1vdfcwQFX+JSPwuHzw7XtXmMCqTgadbtR9eQ9Lu84bT?=
 =?us-ascii?Q?LsSlihRlAKZlsBdfKMUTYusH3d14Dw6vAoV0JH9j89N9+oIS9Nbe1Bd59pzF?=
 =?us-ascii?Q?p5aAk4N+UgtxMP5+K4iJgemYAjdHr6K+O3inIy7hq8tNINnKkUXr9GfmrI+3?=
 =?us-ascii?Q?2yYSAqq22zKc0MbuBbdmrJOetOup/w3ardQd/nR7jVQZNHFngUHJ0/EPoEVb?=
 =?us-ascii?Q?9eReQJR/wfOtD5pb1eFElNS+uxzPT1mhpWTuDJVLMYbs/UwYlN1nbtWPs1DC?=
 =?us-ascii?Q?nhNNViyRZd/CjNrHCJQMDsCBbZo7veGg0cXtAz8qZxlhdzDfRm+TY/xdQuBM?=
 =?us-ascii?Q?b6Fh8Ty8RaP85bmXw4V+ZUgyk4nsdhwjNhztrjcpRL4b+BD02gFEfjHbgdxD?=
 =?us-ascii?Q?GJemeo5q5sU295vRIsXzeX4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84dc514-7f15-432f-d11c-08d9f061475f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 08:58:04.7404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xudhlllqi5UVJ7tvtMqhrBM+oDxvfTAyIfYd6gu/3oCKcQCMNpn8WCkW0/cINWJaATr4cW5e5CkpJRrUOBuyAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi Luben,

I suggest holding on this pls. Harvest bit per IP data structure from VBIOS=
 is not consistently correct. Exposing it to use via sysfs may confuse user=
s.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Luben Tu=
ikov
Sent: Tuesday, February 15, 2022 7:22 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Tuikov, Luben <Luben.Tu=
ikov@amd.com>
Subject: [PATCH] drm/amdgpu: Add "harvest" to IP discovery sysfs

Add the "harvest" field to the IP attributes in the IP discovery sysfs visu=
alization, as this field is present in the binary data.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index c8dbdb78988ce0..0496d369504641 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -393,6 +393,7 @@ struct ip_hw_instance {
 	int hw_id;
 	u8  num_instance;
 	u8  major, minor, revision;
+	u8  harvest;
=20
 	int num_base_addresses;
 	u32 base_addr[];
@@ -440,6 +441,11 @@ static ssize_t revision_show(struct ip_hw_instance *ip=
_hw_instance, char *buf)
 	return sysfs_emit(buf, "%d\n", ip_hw_instance->revision);  }
=20
+static ssize_t harvest_show(struct ip_hw_instance *ip_hw_instance, char=20
+*buf) {
+	return sysfs_emit(buf, "0x%01X\n", ip_hw_instance->harvest); }
+
 static ssize_t num_base_addresses_show(struct ip_hw_instance *ip_hw_instan=
ce, char *buf)  {
 	return sysfs_emit(buf, "%d\n", ip_hw_instance->num_base_addresses);
@@ -471,6 +477,7 @@ static struct ip_hw_instance_attr ip_hw_attr[] =3D {
 	__ATTR_RO(major),
 	__ATTR_RO(minor),
 	__ATTR_RO(revision),
+	__ATTR_RO(harvest),
 	__ATTR_RO(num_base_addresses),
 	__ATTR_RO(base_addr),
 };
@@ -708,6 +715,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_dev=
ice *adev,
 			ip_hw_instance->major =3D ip->major;
 			ip_hw_instance->minor =3D ip->minor;
 			ip_hw_instance->revision =3D ip->revision;
+			ip_hw_instance->harvest =3D ip->harvest;
 			ip_hw_instance->num_base_addresses =3D ip->num_base_address;
=20
 			for (kk =3D 0; kk < ip_hw_instance->num_base_addresses; kk++)

base-commit: d8604f1d237a145db48bae4ea60b85a5875df307
--
2.35.1.102.g2b9c120970
