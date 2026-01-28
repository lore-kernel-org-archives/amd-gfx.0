Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643BAD35668
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 03:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4EEB10E103;
	Wed, 28 Jan 2026 03:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3VZk5BF9";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012040.outbound.protection.outlook.com
 [40.107.200.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85EF410E103
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 03:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XubZJGjD8gubNgEkzZgunN+TCTWzJi03gLtyQSb+sYqjnaZVqg/Y+MvsEencORfynK8bUOtQeFWlNyGSa9Iqj6ETkmbtNDYGwzinfVa8NBoJUBSUYhypwp97fTxFmw7mGdwAc8+1jItAF/semLai7rnTksCnD7KwQYOCTGHmgrvPJwheYMDXdAer9eP+NgagFVBWz0Mr4CpAst4QN1tKDr2Yr90o+X0dZFZugRHtYvJEn7SPTnSz6JQPji5AZ4PFEK/HhGpjAiwvD1vU7YRfuLbB1oSUSAtlQ2gtyqme6hj0lf2ejekPFZlys3V+0qAqcD3dNvpg1xrfA3n4bgimCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qa2vX9ES2ETdmOSCWtsC+mg/jBb7Wfyd27x0txwZJKU=;
 b=AvQaUAwFOFne9bq+BBlb9p2yEOfMcx5Ze1VssF/pxoX36j1vAb96slKzOU2WLMd0EVvjL44isI1DYPiZFshq0ktelIRGCX6OfKJckUwRp4FGmLTR0j9iDqChS7tHk/ZemS46JmhYo84PNnmL9gQ+zgyXAvTYaa/o5HMeK+Ae3wX9XGsWPUSJW8kiUuaU5aFBLbv6GNuvCoOhNGMG04n+P3u8M8o2JpJn12/s0aePqxFxUhocYFAraDKH4ka+0v0sgzeDk98Ad+gcnEXatkbZEzpja5Hs9GU1r6ZDa3mkwGuCE3b981hZXfuiZRv8nn5euWacOym7EztDyR1v+GO31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qa2vX9ES2ETdmOSCWtsC+mg/jBb7Wfyd27x0txwZJKU=;
 b=3VZk5BF9A/uCcRXwQRUGwPhdt/+Aeju8MgwF1pg6ZYH30Hu48vj9o79Tgbu7rG+2Lz+/EC8qjHaK1sBCDzso36O+kYU3uVuEzsFDkKw9PT10KRhWhxWO1lTpCEHbduKFexncya1aOQCmqECvcV3n26VJGdPc/cPJcJHkipFWYwQ=
Received: from SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 03:31:28 +0000
Received: from SJ0PR12MB6903.namprd12.prod.outlook.com
 ([fe80::e7ba:9293:d605:19a8]) by SJ0PR12MB6903.namprd12.prod.outlook.com
 ([fe80::e7ba:9293:d605:19a8%4]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 03:31:27 +0000
From: "Wang, Beyond" <Wang.Beyond@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Jin, Jason(Yong)"
 <JasonYong.Jin@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Avoid redundant allocate/free when reusing a
 bo_list handle
Thread-Topic: [PATCH] drm/amdgpu: Avoid redundant allocate/free when reusing a
 bo_list handle
Thread-Index: AQHci3TUDaoCSodV3EGyLED2DvG7G7Vl7oUAgADz++A=
Date: Wed, 28 Jan 2026 03:31:27 +0000
Message-ID: <SJ0PR12MB6903D0FB966D83323492C65CF791A@SJ0PR12MB6903.namprd12.prod.outlook.com>
References: <SJ0PR12MB69035C332189D35E4D5A81C6F797A@SJ0PR12MB6903.namprd12.prod.outlook.com>
 <547a73eb-edca-40c3-a22b-8403dba49a30@amd.com>
In-Reply-To: <547a73eb-edca-40c3-a22b-8403dba49a30@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-28T03:31:28.6730000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6903:EE_|LV8PR12MB9206:EE_
x-ms-office365-filtering-correlation-id: aeee2537-40e9-41a6-4aab-08de5e1db8b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?eaFl8Uw1fgVhyr0jKLQA9Bw0kkFParGJAKwPM5BnaT9lEPFrfmWAC7Jqha?=
 =?iso-8859-1?Q?U89VF2BfwRyvuiW3ILcLld0SqGzrVoif0Hh7ooI8cRrg6pEWsFqtwgikYL?=
 =?iso-8859-1?Q?l464LzYZmVT7qWl+Mfs3P7rJJAYya2Ybm81QHCRoVs8PER0QdoJ6qFgnYP?=
 =?iso-8859-1?Q?+Y1vvjGwU9//oOC7vSECeQQb3QEi6VtCIOPMCXmlgRyPHRQYye4j14ejDv?=
 =?iso-8859-1?Q?HiDJX6GLM4A1bMJkQxdwWFpnkbEvVnuvfqV9U6KsfSYsg4/AvMkgDzvw25?=
 =?iso-8859-1?Q?3h6mv/lGhKl1Q37zsGr4HsQ5kL6WYlvpH4Ixqk37m+D3jfsXm6XOE3CBQF?=
 =?iso-8859-1?Q?dhPl0XxTovJaEaTR6rPD9pfC/0rKAllMMPFDauyUKqVS61gbfdftBVh0E+?=
 =?iso-8859-1?Q?FELxfqBFs6aOO0hj02tWidadY6TrA8ORyOPlmhHHnaXMoN0GzvVVkOyXr6?=
 =?iso-8859-1?Q?PeqyGiYtO/KTki6bBdqCBRJfYfwxV5KJk0yilko+lPLGp89Do6W8Z8Cedb?=
 =?iso-8859-1?Q?HuI8jC0bVbT7EYCgtaf7AuUkTnofFbT0n2VGDVRowhGww2yHo9M49VL3Bl?=
 =?iso-8859-1?Q?fqwvx1eO0lBTL+Y7Jk8t2CCRWT+uLMESySbLOhOdnpEhcrs9Ve3DoA4FDy?=
 =?iso-8859-1?Q?6OsutYhuaep54HayJGQZ3ohPAOeg6F/tbK6zsiTTK0rIcrWqGJgB2liMGA?=
 =?iso-8859-1?Q?rpZjMvdF789yxFQYDFO5pPlrlnL5G0pvD+VXBovMtVVPHX2LOlHTl9MCJi?=
 =?iso-8859-1?Q?/xL9udSKl81fBu2OTeZO6fsq1hKu4UteiR6Ngq7Sf5PuknsCgG6DRAw6FE?=
 =?iso-8859-1?Q?f7Vlx2/2XLupNt1ODyI6fJDzaNL5RmO136B3+KOKUrc51Cfrqt/0v5KFmz?=
 =?iso-8859-1?Q?aqak2fEVwFEvlEZxaLuGddcuxQvbwzbEk0WrfGx/oz19B5wLWArjwXnAzz?=
 =?iso-8859-1?Q?CdExice14D0s4hrOjV2tIqUlKhf9TqH43fk3TyOIdp08AD32IY2ChiYLAE?=
 =?iso-8859-1?Q?479KUW08S1bLnZ+bqxFkX93+Jk9Uyxhw0ZOmfpyWRviH141u/CJEnBXz2Q?=
 =?iso-8859-1?Q?gNzJUWDtUSLoWDmYuB7Lqib4q8Sgux1kY0IFPCO+QuYX1YhxBT0V1qth32?=
 =?iso-8859-1?Q?RMLS9Y7jZsYMBRUG19dr5BNvqQDFhgcLvvNMpLnNhKdqDthXabm5hMc+w8?=
 =?iso-8859-1?Q?gWUaW9CLEy+ppDcz+KD0U7KMXPRIhu+kOkhjH+Z+ri3FZgSiOww6UNSC/N?=
 =?iso-8859-1?Q?pk0I39D+PnaL4ebPTK3GcGYKJp2aGN4ywBK3ZV8+yD7gqedeImpnYRwW1t?=
 =?iso-8859-1?Q?D0MWU9GdHKoXnZZ0QS6tnqX+f6fUzujPcGkbSw4/sAh/iqg5oDA9GjGx0W?=
 =?iso-8859-1?Q?r/vugnOFfSm4rAZOO+us1EwKOwkNutRfisBx+sdT7UFFWRKDVGUO4jRw4+?=
 =?iso-8859-1?Q?VfDMI4pUwwtGZekzNK4Hkj2SIrKmLZAF4xEdgiNcw6w7VT9GK7g0S12TEK?=
 =?iso-8859-1?Q?c6Hy2pwLQYFJs4bDv1iA99dUufwyGVUDn5guEH7rxGSAzhLmIpW+Lemh/Y?=
 =?iso-8859-1?Q?Yhjc1bm7UZ/n0FbghwgStWBdHsXZnomwHNPGTyQ83/81iQ1UQ4txH0xaZz?=
 =?iso-8859-1?Q?xh2CPRajiFvFK319+/LpusVn3r30XBKx2kl7rzyY9rhgfZetQHVLo4fLRq?=
 =?iso-8859-1?Q?HD/zRLEKuN7EPFbAxvY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6903.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g5RBqLuGG4T43o+tI4kdQT4BYwMS3vFOturtOwoymEANe5BedlMX6cbcU1?=
 =?iso-8859-1?Q?yQ6yLjTxEjisAZ2XHvaHR3amMO8Lxr8S6dNFtuYFqmGgObNjhxNCJquRPn?=
 =?iso-8859-1?Q?i49uPMQM9ah5+xMG5q7SYatZ29H7LsMP+E9vAQ7Eu/tl+V3Rdnzzf3fxAk?=
 =?iso-8859-1?Q?FTdsZTBZDRHy65Z1OMhgZ0Uw3GAy2WGQqgx+dZYTC4Rrw6+jz5US7K6yJW?=
 =?iso-8859-1?Q?6L1cZT0+xNT8zXK0Ya5ZGWiLoG626qK73jAEf76Z+v9VmSIrRpabXfAi53?=
 =?iso-8859-1?Q?H/iquPxDy/SJhCQrDEbthhFjSHPq/5qkdhgotVB9T69ZUEUDwvhSp2CBkX?=
 =?iso-8859-1?Q?0OvdlM/mXrpd4Dg4jXxDz91xiwZD/wial5Ua7bPs+jj/DFmBA0qJAZg07L?=
 =?iso-8859-1?Q?E6o8JNP9QqG43C+02HjpNfOEzyn5yvsCP8OQJroxeYZ6JhzTHTLpNRGVhe?=
 =?iso-8859-1?Q?pdl0DYDMxHJaiab0BnQW4MFghabqp94jljMR/DN+H3rFNC6uNH1jsr07KK?=
 =?iso-8859-1?Q?TO6QB1eezO+g+8KPQvnn6mWCsxLSZ7Rt5Bd7eHAC8K6bWwg2jxsQSfgAAV?=
 =?iso-8859-1?Q?6oeHmqIzWLCR2zGu2wJtqJbbwkXXo+I0PPg1zfNsb3v5yY14BNpW3qAElA?=
 =?iso-8859-1?Q?aJiOXgy+gkAGGBZCuiQa0hEkXHNfbS6kHX+xElSI6Z8ZV4Y98x0RvSFmLK?=
 =?iso-8859-1?Q?rFwd+ouGnb+qKFAQlgW57UiWOtV2enkG58OGOVkspSG5BtRXT4v3LNfL8w?=
 =?iso-8859-1?Q?XbmCmd0z3easCJZFybGqXGuJDYz1wGc6g9LBB7pURePBBtvI99ZD94IKc1?=
 =?iso-8859-1?Q?LPZBNpJyrfzceN1+DehzzxCI5p3H6pNBh/1PZ9t2/d5kJF8R+VZmx2wbHM?=
 =?iso-8859-1?Q?XphCAyVoK9JBSSkHPKaCdSrlrTEClqQuphyzLgftpNGlT8H8XZ6wcYZQQH?=
 =?iso-8859-1?Q?Ljnt7y2bkU8/5ZcBParbjgsYBIbBSu0Z7CoaOIkff8iVD56gAaOMNI1Ug1?=
 =?iso-8859-1?Q?neXlzZQkKjpe0uaEO1Km0s8O5ubk6qjSMGAQahdRoG2ufjb0FufFtzd5af?=
 =?iso-8859-1?Q?z9G6tn9vT02o5RjlNnt9+Za6D0dyYo4Rt9sALdHOYBDPeJpcmPVxLksCmM?=
 =?iso-8859-1?Q?UJNpRalWdA5CJA1cge5oCmZUg7R69nDXlHPJfGvshqnWlGFKaC+oHCPMAd?=
 =?iso-8859-1?Q?/tBEfCnOI/8oqGwyVYF7qm530QYXh0QNqU1wJx7Zpjdi5wIvx2q0gMO+P5?=
 =?iso-8859-1?Q?YnKMnGtRHxHQjdTBOeXaBFI4tttTtLOwc3HnSLm3+rNC1gGVNI50S8kBpk?=
 =?iso-8859-1?Q?73AO8Kujgoqokdgn7QgbFR2vOo51HCqH+HjIGPxnWSHin5dHHV5uFBtwXJ?=
 =?iso-8859-1?Q?YaMJzwXV2uiHE3DOReHrs09pq2VewYtQkFiYVbFfBGmmq8znhFtHY0aleO?=
 =?iso-8859-1?Q?oPe7hhubISOiM6/lE+Vmvo8cldQFAtC2yHmEYZw2jracbinRnNBxh2j8XD?=
 =?iso-8859-1?Q?e/GAU1aNfYhs8Lmg86y+Q3Xtpbh6IZGsJ9eXFDRXssoPF3TmBbKYqyCCjB?=
 =?iso-8859-1?Q?dzjNL5fW3qh00GSZeFs/Exp3U1EA8d9BRv5gNaCbR2XGiPJtan0uD8D5wZ?=
 =?iso-8859-1?Q?mSwRZwll6a7yuRpQEodophzftyL46bpWk766T1PzJrh6gKa+mlQ1v7lBBP?=
 =?iso-8859-1?Q?ay/AJC63J4iRKVwYjqziz9yZzk4uKkKhXk7ZK7xq9tk0ybKhjZVXSWt6fQ?=
 =?iso-8859-1?Q?MrAlKlbzi5j0Dl/tuj5jiegqdDn8+Z3POvFEId3DtEri/Q?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB6903D0FB966D83323492C65CF791ASJ0PR12MB6903namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6903.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeee2537-40e9-41a6-4aab-08de5e1db8b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 03:31:27.8674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JcFotxMcTx2ePXZwnNYOlSjRw5RCc9lp19fI6B5cgCtocZPtk/yqx0mut773KsX0lZJqYxdrjkG7JIoAqeRDwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206
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

--_000_SJ0PR12MB6903D0FB966D83323492C65CF791ASJ0PR12MB6903namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

I see.

"Additional to that BO lists are not really used that much any more, OpenGL=
 Mesa has completely dropped them IIRC and RADV isn't using them either."

I suppose this is a corner case, here I'm facing a Vulkan App uses lots of =
VK_EXT_external_memory_host,  these kind of BOs created from amdgpu_gem_use=
rptr_ioctl,
and can not be VM_ALWAYS_VALID, that make UMD have to pass all of them to K=
MD on each command buffer submission, this makes amdgpu_cs_parser_bos take
much longer(~1.5ms on strix1), that's why I'm trying to reuse the bo_list h=
andle instead of let KMD creating temporary bo_list on each submission.

Any other suggestions will be grateful.

Thanks,
Beyond
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Tuesday, January 27, 2026 7:47 PM
To: Wang, Beyond <Wang.Beyond@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Jin, Jason(Yong) <Jason=
Yong.Jin@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Avoid redundant allocate/free when reusing=
 a bo_list handle

On 1/27/26 04:12, Wang, Beyond wrote:
> [Public]
>
>
> When a bo_list handle was reused across multi command submission, reusing
> of those allocated HMM range structure can avoid redundant allocate/free
> operations on each submission.
> Doing this way benefits the amdgpu_cs_parser_bos time, especially for
> large bo_list

And creates a massive security issue, so clear NAK to that.

That we have the HMM range in the BO list is extremely questionable to begi=
n with but wasn't doable otherwise in the past.

Additional to that BO lists are not really used that much any more, OpenGL =
Mesa has completely dropped them IIRC and RADV isn't using them either.

Regards,
Christian.

>
> Signed-off-by: Wang, Beyond <Wang.Beyond@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 16 +++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c     | 19 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h     |  2 ++
>  4 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_bo_list.c
> index 66fb37b64388..9c662369d292 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -51,8 +51,10 @@ static void amdgpu_bo_list_free(struct kref *ref)
>                            refcount);
>     struct amdgpu_bo_list_entry *e;
>
> -   amdgpu_bo_list_for_each_entry(e, list)
> +   amdgpu_bo_list_for_each_entry(e, list) {
> +       amdgpu_hmm_range_free(e->range);
>         amdgpu_bo_unref(&e->bo);
> +   }
>     call_rcu(&list->rhead, amdgpu_bo_list_free_rcu);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index ecdfe6cb36cc..fc195fa2c0c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -891,9 +891,13 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_par=
ser *p,
>         bool userpage_invalidated =3D false;
>         struct amdgpu_bo *bo =3D e->bo;
>
> -       e->range =3D amdgpu_hmm_range_alloc(NULL);
> -       if (unlikely(!e->range))
> -           return -ENOMEM;
> +       if (!e->range) {
> +           e->range =3D amdgpu_hmm_range_alloc(NULL);
> +           if (unlikely(!e->range))
> +               return -ENOMEM;
> +       } else {
> +           amdgpu_hmm_range_reset(e->range);
> +       }
>
>         r =3D amdgpu_ttm_tt_get_user_pages(bo, e->range);
>         if (r)
> @@ -995,8 +999,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_pars=
er *p,
>
>  out_free_user_pages:
>     amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> -       amdgpu_hmm_range_free(e->range);
> -       e->range =3D NULL;
> +       amdgpu_hmm_range_reset(e->range);
>     }
>     mutex_unlock(&p->bo_list->bo_list_mutex);
>     return r;
> @@ -1327,8 +1330,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser=
 *p,
>     r =3D 0;
>     amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>         r |=3D !amdgpu_hmm_range_valid(e->range);
> -       amdgpu_hmm_range_free(e->range);
> -       e->range =3D NULL;
> +       amdgpu_hmm_range_reset(e->range);
>     }
>     if (r) {
>         r =3D -EAGAIN;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_hmm.c
> index 90d26d820bac..5b72ea5a3db7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -273,6 +273,25 @@ struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(stru=
ct amdgpu_bo *bo)
>     return range;
>  }
>
> +/**
> + * amdgpu_hmm_range_reset - reset an AMDGPU HMM range
> + * @range: pointer to the range object to reset
> + *
> + * Free the hmm_pfns associated with range, but keep the allocated struc=
t range
> + * for reuse, in order to avoid repeated allocation/free overhead when t=
he same
> + * bo_list handle reused across multiple command submissions.
> + *
> + * Return: void
> + */
> +void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *range)
> +{
> +   if (!range)
> +       return;
> +
> +   kvfree(range->hmm_range.hmm_pfns);
> +   range->hmm_range.hmm_pfns =3D NULL;
> +}
> +
>  /**
>   * amdgpu_hmm_range_free - release an AMDGPU HMM range
>   * @range: pointer to the range object to free
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_hmm.h
> index 140bc9cd57b4..558f3f22c617 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> @@ -44,6 +44,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_noti=
fier *notifier,
>  #if defined(CONFIG_HMM_MIRROR)
>  bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range);
>  struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo);
> +void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *range);
>  void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range);
>  int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr);
>  void amdgpu_hmm_unregister(struct amdgpu_bo *bo);
> @@ -67,6 +68,7 @@ static inline struct amdgpu_hmm_range *amdgpu_hmm_range=
_alloc(struct amdgpu_bo *
>     return NULL;
>  }
>
> +static inline void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *range=
) {}
>  static inline void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range)=
 {}
>  #endif
>
> --
> 2.43.0


--_000_SJ0PR12MB6903D0FB966D83323492C65CF791ASJ0PR12MB6903namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I see.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&quot;Additional to that BO lists are not really used that much any more, O=
penGL Mesa has completely dropped them IIRC and RADV isn't using them eithe=
r.&quot;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I suppose this is a corner case, here I'm facing a Vulkan App uses lots of =
VK_EXT_external_memory_host,&nbsp; these kind of BOs created from amdgpu_ge=
m_userptr_ioctl,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
and can not be VM_ALWAYS_VALID, that make UMD have to pass all of them to K=
MD on each command buffer submission, this makes amdgpu_cs_parser_bos take<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
much longer(~1.5ms on strix1), that's why I'm trying to reuse the bo_list h=
andle instead of let KMD creating temporary bo_list on each submission.</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Any other suggestions will be grateful.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Beyond</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, January 27, 2026 7:47 PM<br>
<b>To:</b>&nbsp;Wang, Beyond &lt;Wang.Beyond@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b>&nbsp;Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Jin, =
Jason(Yong) &lt;JasonYong.Jin@amd.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH] drm/amdgpu: Avoid redundant allocate/free =
when reusing a bo_list handle
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">On 1/27/26 04:12, Wang, Beyond wrote:<br>
&gt; [Public]<br>
&gt;<br>
&gt;<br>
&gt; When a bo_list handle was reused across multi command submission, reus=
ing<br>
&gt; of those allocated HMM range structure can avoid redundant allocate/fr=
ee<br>
&gt; operations on each submission.<br>
&gt; Doing this way benefits the amdgpu_cs_parser_bos time, especially for<=
br>
&gt; large bo_list<br>
<br>
And creates a massive security issue, so clear NAK to that.<br>
<br>
That we have the HMM range in the BO list is extremely questionable to begi=
n with but wasn't doable otherwise in the past.<br>
<br>
Additional to that BO lists are not really used that much any more, OpenGL =
Mesa has completely dropped them IIRC and RADV isn't using them either.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Wang, Beyond &lt;Wang.Beyond@amd.com&gt;<br>
&gt; ---<br>
&gt; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | &nbsp;4 +++-<br>
&gt; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c &nbsp; &nbsp; &nbsp;| 16 =
+++++++++-------<br>
&gt; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c &nbsp; &nbsp; | 19 +++++=
++++++++++++++<br>
&gt; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h &nbsp; &nbsp; | &nbsp;2 =
++<br>
&gt; &nbsp;4 files changed, 33 insertions(+), 8 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_bo_list.c<br>
&gt; index 66fb37b64388..9c662369d292 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c<br>
&gt; @@ -51,8 +51,10 @@ static void amdgpu_bo_list_free(struct kref *ref)<b=
r>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;refcount);<br>
&gt; &nbsp; &nbsp; struct amdgpu_bo_list_entry *e;<br>
&gt;<br>
&gt; - &nbsp; amdgpu_bo_list_for_each_entry(e, list)<br>
&gt; + &nbsp; amdgpu_bo_list_for_each_entry(e, list) {<br>
&gt; + &nbsp; &nbsp; &nbsp; amdgpu_hmm_range_free(e-&gt;range);<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; amdgpu_bo_unref(&amp;e-&gt;bo);<br>
&gt; + &nbsp; }<br>
&gt; &nbsp; &nbsp; call_rcu(&amp;list-&gt;rhead, amdgpu_bo_list_free_rcu);<=
br>
&gt; &nbsp;}<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_cs.c<br>
&gt; index ecdfe6cb36cc..fc195fa2c0c0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; @@ -891,9 +891,13 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_=
parser *p,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; bool userpage_invalidated =3D false;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; struct amdgpu_bo *bo =3D e-&gt;bo;<br>
&gt;<br>
&gt; - &nbsp; &nbsp; &nbsp; e-&gt;range =3D amdgpu_hmm_range_alloc(NULL);<b=
r>
&gt; - &nbsp; &nbsp; &nbsp; if (unlikely(!e-&gt;range))<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -ENOMEM;<br>
&gt; + &nbsp; &nbsp; &nbsp; if (!e-&gt;range) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; e-&gt;range =3D amdgpu_hmm_range_=
alloc(NULL);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (unlikely(!e-&gt;range))<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -ENOMEM;<br>
&gt; + &nbsp; &nbsp; &nbsp; } else {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; amdgpu_hmm_range_reset(e-&gt;rang=
e);<br>
&gt; + &nbsp; &nbsp; &nbsp; }<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; r =3D amdgpu_ttm_tt_get_user_pages(bo, e-&=
gt;range);<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; if (r)<br>
&gt; @@ -995,8 +999,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_p=
arser *p,<br>
&gt;<br>
&gt; &nbsp;out_free_user_pages:<br>
&gt; &nbsp; &nbsp; amdgpu_bo_list_for_each_userptr_entry(e, p-&gt;bo_list) =
{<br>
&gt; - &nbsp; &nbsp; &nbsp; amdgpu_hmm_range_free(e-&gt;range);<br>
&gt; - &nbsp; &nbsp; &nbsp; e-&gt;range =3D NULL;<br>
&gt; + &nbsp; &nbsp; &nbsp; amdgpu_hmm_range_reset(e-&gt;range);<br>
&gt; &nbsp; &nbsp; }<br>
&gt; &nbsp; &nbsp; mutex_unlock(&amp;p-&gt;bo_list-&gt;bo_list_mutex);<br>
&gt; &nbsp; &nbsp; return r;<br>
&gt; @@ -1327,8 +1330,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_par=
ser *p,<br>
&gt; &nbsp; &nbsp; r =3D 0;<br>
&gt; &nbsp; &nbsp; amdgpu_bo_list_for_each_userptr_entry(e, p-&gt;bo_list) =
{<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; r |=3D !amdgpu_hmm_range_valid(e-&gt;range=
);<br>
&gt; - &nbsp; &nbsp; &nbsp; amdgpu_hmm_range_free(e-&gt;range);<br>
&gt; - &nbsp; &nbsp; &nbsp; e-&gt;range =3D NULL;<br>
&gt; + &nbsp; &nbsp; &nbsp; amdgpu_hmm_range_reset(e-&gt;range);<br>
&gt; &nbsp; &nbsp; }<br>
&gt; &nbsp; &nbsp; if (r) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; r =3D -EAGAIN;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_hmm.c<br>
&gt; index 90d26d820bac..5b72ea5a3db7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c<br>
&gt; @@ -273,6 +273,25 @@ struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(s=
truct amdgpu_bo *bo)<br>
&gt; &nbsp; &nbsp; return range;<br>
&gt; &nbsp;}<br>
&gt;<br>
&gt; +/**<br>
&gt; + * amdgpu_hmm_range_reset - reset an AMDGPU HMM range<br>
&gt; + * @range: pointer to the range object to reset<br>
&gt; + *<br>
&gt; + * Free the hmm_pfns associated with range, but keep the allocated st=
ruct range<br>
&gt; + * for reuse, in order to avoid repeated allocation/free overhead whe=
n the same<br>
&gt; + * bo_list handle reused across multiple command submissions.<br>
&gt; + *<br>
&gt; + * Return: void<br>
&gt; + */<br>
&gt; +void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *range)<br>
&gt; +{<br>
&gt; + &nbsp; if (!range)<br>
&gt; + &nbsp; &nbsp; &nbsp; return;<br>
&gt; +<br>
&gt; + &nbsp; kvfree(range-&gt;hmm_range.hmm_pfns);<br>
&gt; + &nbsp; range-&gt;hmm_range.hmm_pfns =3D NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; &nbsp;/**<br>
&gt; &nbsp; * amdgpu_hmm_range_free - release an AMDGPU HMM range<br>
&gt; &nbsp; * @range: pointer to the range object to free<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_hmm.h<br>
&gt; index 140bc9cd57b4..558f3f22c617 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h<br>
&gt; @@ -44,6 +44,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_n=
otifier *notifier,<br>
&gt; &nbsp;#if defined(CONFIG_HMM_MIRROR)<br>
&gt; &nbsp;bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range);<br>
&gt; &nbsp;struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo=
 *bo);<br>
&gt; +void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *range);<br>
&gt; &nbsp;void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range);<br>
&gt; &nbsp;int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr=
);<br>
&gt; &nbsp;void amdgpu_hmm_unregister(struct amdgpu_bo *bo);<br>
&gt; @@ -67,6 +68,7 @@ static inline struct amdgpu_hmm_range *amdgpu_hmm_ra=
nge_alloc(struct amdgpu_bo *<br>
&gt; &nbsp; &nbsp; return NULL;<br>
&gt; &nbsp;}<br>
&gt;<br>
&gt; +static inline void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *ra=
nge) {}<br>
&gt; &nbsp;static inline void amdgpu_hmm_range_free(struct amdgpu_hmm_range=
 *range) {}<br>
&gt; &nbsp;#endif<br>
&gt;<br>
&gt; --<br>
&gt; 2.43.0<br>
<br>
</div>
</div>
</body>
</html>

--_000_SJ0PR12MB6903D0FB966D83323492C65CF791ASJ0PR12MB6903namp_--
