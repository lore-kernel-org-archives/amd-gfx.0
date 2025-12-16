Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B741BD5B86C
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 02:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3DC310E0A9;
	Tue, 16 Dec 2025 02:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gLHDmAmT";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB18610E0A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 02:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAfgK9E+rvV95cNUs/rIP612S3Zw9/zsMdocdXuW6toltXYBrqeocrwjPTKCwm4oGIIlMdrqDbD40axjaTPMpZVun1xl6MnuOqEzDvYXfrKBQ9bNuqWRJCyZknlf2IG9MtDlo6jVXZhC2Wj7s0E2/uSyvKk8XZRTqM5MZ3a7oZN2lQPEaYaEXhpvnntqhX22E3UuQfKvjGFNKKoEXQVf8eex1WDfLAUFihWhYn633P8wSFLwuBZFSHVPDbjcvokuy+V7T8aotq1rwuN8fi1CJxsdNjEB3PXlAH9/G84mnf+YrBX9O+GqwCzVYTLEQT4W0a4VPsjvCAl9zXVqp/gRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjgARNq4n7t5IvoGB4Z4kiGXR50QjJlp8ouFyWzH2BI=;
 b=MThmUSXVmlJk3Lv7aQXIbdCAwk1ssYBAg94cUhSdo6nQrVW2Knd4U/MxuBAW43ZElY82WDXkwRVYLHrakLpy34FlhqlR9xtjlz74w+nEJE7myp4mCQ+V/Ypp3Cjfwjq2Agipkdom8LLdtdPh050M3bwowW7EvjFKbAfjyrNVG7zYFVoGefuH/+tyxFPvvpMMYoFwrRVCVWCHnqNKabL/T5bpC80Q2w+iZnaW6Ay0pEp77SEfQUpVJcmI8LyJixcDDVnlidY7eLheMQPtGNZ5he9+atRFu9+i3cRy2V2fwa9/yqvmIJW8GUwHRQOLV4wvBg+I2vd/icciV/uoLNG+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjgARNq4n7t5IvoGB4Z4kiGXR50QjJlp8ouFyWzH2BI=;
 b=gLHDmAmTfe6k52Wa3sWcnhGjt4r+toQcLVSaBA2mQjU3wTL1eLGMb/yBWz9hylzA/xkKHwxQHEc2D0b9uDB8yU3GLdyOfFvH47sQM+1Ppfraj8fW6/enmNZwSkw44GSbjmRlVljq8KfDxWV6qiAFj/f4MVeijcmtGOwAZoz7qsM=
Received: from IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 02:42:42 +0000
Received: from IA0PR12MB7675.namprd12.prod.outlook.com
 ([fe80::b2f4:4979:b048:3060]) by IA0PR12MB7675.namprd12.prod.outlook.com
 ([fe80::b2f4:4979:b048:3060%2]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 02:42:42 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/3] amdkfd: Don't rebuild node tree when calling
 kfd_topology_update_sysfs()
Thread-Topic: [PATCH v2 2/3] amdkfd: Don't rebuild node tree when calling
 kfd_topology_update_sysfs()
Thread-Index: AQHcahG98mhwjHDAIUWIJh0c1IBAurUjlJ/P
Date: Tue, 16 Dec 2025 02:42:42 +0000
Message-ID: <IA0PR12MB7675EFE383C2C21C0E0134F28CAAA@IA0PR12MB7675.namprd12.prod.outlook.com>
References: <20251210201510.3000-1-superm1@kernel.org>
 <20251210201510.3000-3-superm1@kernel.org>
In-Reply-To: <20251210201510.3000-3-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-16T02:42:42.916Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7675:EE_|SJ0PR12MB7458:EE_
x-ms-office365-filtering-correlation-id: a04fd375-4559-4b36-75a4-08de3c4cc963
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?a2ITy3oXhVQta4mcZ1bs1QQMENzicH29niNeYwRq/Mzb4+kDF6sJPLJHjR?=
 =?iso-8859-1?Q?Cwc+RFy8t7hypnpuXHjGBBfCjAkr6TRVVg7nfI4RR2QnTx9EPQo38inwDW?=
 =?iso-8859-1?Q?cuhlSHxo9/mdcqISRWgLF1clIlRY26LYj0OUAtdECGjkNdINzOGiM0z91e?=
 =?iso-8859-1?Q?frNYxYVZJaisCEOTk+B1/ImI2XlsSiRzsK6Lsl2rHnPQJZZ4LCe4QbHLAR?=
 =?iso-8859-1?Q?dapuDV96pm365y5B8jrpvbYBtZBAYul3E+k6SKtvHQDhSFXDXWAYiqPZ+0?=
 =?iso-8859-1?Q?xAnmgnkhro6Gu/h79AYE4bJ9UTozEPBuRu0wxDN9gjmibh/V2wZjmFpZr+?=
 =?iso-8859-1?Q?uFc9KNcgBtsU6ClMqk6EAVcoH6CjRXIBK8LNz5G6w6hndZCvPVEzkrky+u?=
 =?iso-8859-1?Q?4R9OIkFQUqTJWZQ6saT2obUCju8SVPxUGAGpg5CYEkoT7CClz32/MKX27d?=
 =?iso-8859-1?Q?F9wRW07v11QlfymRqktC4IPi77W9L1C8WHpa9p28wm5AyUlv0uDTwjX++m?=
 =?iso-8859-1?Q?Z9jbWbDFFI/cXIGvarl/V0uCzgPg5aBgBh3VUc6Z6GdmDej//YRXRMZVkg?=
 =?iso-8859-1?Q?Zh3zFWtszdsmuAXgHMOPgCQBwvnj3iDdxvWZ04TDrDc5FqeaRJD7DJx726?=
 =?iso-8859-1?Q?yvHqftA/eQn2XngirIX5US09yK7I4cEozs9DW2lkeuNsFS46Io3dhG1Zpc?=
 =?iso-8859-1?Q?iPbD48W+YG+lI51bu6b/DqcvkNzxnLGodAhD/SNuMBQZWqMIfw/MQfFpRR?=
 =?iso-8859-1?Q?mVUw5JYh/d6xqdiNpllDNtAiRnzkdbJ48YkRC32Lb2Z11f3l8e6vWRAITR?=
 =?iso-8859-1?Q?oG8zdH1unrU2OL1w3r8zcWGsB9IvTAtWPQzOKtSb8kgiiWHeZumzmyoz2w?=
 =?iso-8859-1?Q?VraKlkgINPFnCpnw6ZV3Ck77NnXWqYuY9fvpdkuR7ZTvom9SgNdfPJ9HUw?=
 =?iso-8859-1?Q?P2LtES9C8CWJZSUSKkoIgAMX56/ISolQ6BJnLTONIQtDx72gkDpWzkOMzB?=
 =?iso-8859-1?Q?7MrewI95uzXjAOGxXFkG0au8Wf7nZtWJ7o68DZt9dU82XeYb0s4sDLsh4q?=
 =?iso-8859-1?Q?k00I+GavFCeWfQMGFcu6UP676rrQ0k9PDzLluZc9ZrJTW6Ze3o8rFHPM8H?=
 =?iso-8859-1?Q?IcyqzqpwG9ULwnn0qgwqm+RJif9AGhT+UTRFtmY2dCy7z0CGqzipr4BhdX?=
 =?iso-8859-1?Q?q0Q25pYzuQ+NAMGkilW0GOZ2NZZb+ofCU7DcgQ3yWKUS7EWQrVe5Z0SlHZ?=
 =?iso-8859-1?Q?K1OKxXK1KA4VV3IpPxuK1/ftT3MwCf/6DHraqY2Tk7wdfYjhk1NcrEwRLY?=
 =?iso-8859-1?Q?B2LITERUYxCLaJPqEvid6Oxmb1YUdFkqpk+0i0uhkmWuyDayQwrQxSdqBa?=
 =?iso-8859-1?Q?/3TwRlky5o4WTseC9PIrrSLgVP8uirUpWP8MmiVMnyaWX4E3p3oiSOfX09?=
 =?iso-8859-1?Q?S3pC9ek6ooiv1f95C+9eHrKZdiwiG6frqzFe8OeFqmfEAZdY5lVlYlBjFi?=
 =?iso-8859-1?Q?2M8pzGAxJViFS4TJpoaBzFahsplaQOZCqCBJSV64bxJsO3dpReID+1GDqY?=
 =?iso-8859-1?Q?kSJofbx6mPjKJpA1Uy1giAbbry1g?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7675.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4ICxZ/yiQG786MFdp3ZVTLKgHD34YNThqm8/Tby2VY3YlPd09m8ajaCkbS?=
 =?iso-8859-1?Q?SH7112LhiNMMiznBqy65RmlxiwtxdULQ2PBXV360IWvZ7pdNW70rBqfXNo?=
 =?iso-8859-1?Q?751YUT2bUTWfqi/KOMZN1Hj9IcNhqXadFhj1xJvYR+G387d8kSMuA2vQkz?=
 =?iso-8859-1?Q?wiKmYpsvjfX1RrRwyaD7GM6bvrSzrbjIIY+wgC2IEuSJrrPKopThyRWrJE?=
 =?iso-8859-1?Q?vMOm3sbNd5SHXCcTBbjQpDrlXSusUDfozJH/zkyzZSmL/BJxrfmdJDFR5g?=
 =?iso-8859-1?Q?xrA2Txf1NSprspqqZT7Jjnn8UOZLEAkK8kMrG/WEjGRJMkY3kGbqUTnRY+?=
 =?iso-8859-1?Q?/ZsQ071AeNKEPccLLePHklXxP7MLDAAD2kyZGLrHbYuM695UP40Vy+fivK?=
 =?iso-8859-1?Q?PUU9750Yv0s/sqx8Q/ALQ4XJKApOajQq9nq8XB2T8v0jpKgjglpYSdgOvE?=
 =?iso-8859-1?Q?oNvOFlSuML/gwn0d5Baywsutu21MvuLb3s8x/Ouar9ZPvc4HGZsFjIvLON?=
 =?iso-8859-1?Q?fK4zjaTRqKoPbwExFhNNw59ucSwyxBOkp3PfXbp//W1D/ZjY7GdqJ3X8TI?=
 =?iso-8859-1?Q?2b/BeWAJjkeK5vDQCWBMr9vkpuxtfXj/jjNs/U8w2IukOv4BeX2HRnjy9r?=
 =?iso-8859-1?Q?vIQz0fePjV8kQlZvJDqpgQXZjiBBN3lN3bAaZEEPDzgm49ajhWy8qcePVd?=
 =?iso-8859-1?Q?51vZcZu7p7kDYdKc62uABKUiFD11KZqMoUScYAJwQZmKtSqObEd+moDmTB?=
 =?iso-8859-1?Q?I9vnP9JNHLvXVN6cJc3PEMGa9B7Sss1jWEvBFPGaMt9fyNubSUpx6pBvUD?=
 =?iso-8859-1?Q?CHdKR131Y/IbVuHLJcf/tU4wCx8HgGMZgWpEsJrQtJ5ycUh5rRsHgtiJN8?=
 =?iso-8859-1?Q?NZ+ZwFuUSgU6+qGD5Ku5Mtoqu8hzKj8yUah48YBIbHGMmRyP6dq8pJfOUa?=
 =?iso-8859-1?Q?y8/m6DkhS90NGFZy7+OiAW5G4JL1LvOHT3K6u/kz+Ee3zKPEMOZwtgyIMS?=
 =?iso-8859-1?Q?/Mrg3JIxEP1gO9FIqDHzpDMBYWVFOiInpk44V9HH9F/X/aIUOyE+n9LR2Z?=
 =?iso-8859-1?Q?PGkpJ3AkChHPSL1I77cSvjuE9fX3THfoAj5aDdkFy1lErtJM8R6NZXDtbF?=
 =?iso-8859-1?Q?kCVstuBEaGMhuHVhKVoGoxXFLFobr5m2PJ5SBuAV44DoZ+Gyk15pYNcPAq?=
 =?iso-8859-1?Q?9MBr63rpEJs/CD9It25h76YDDoAzp1elz12PiIIXYkEjW7q4dRFTMqr9n5?=
 =?iso-8859-1?Q?fdnTuYuasccT9yLl5GLnEpqjKMBenud5gf9ccpLazB1gecmjdDzAu96rlW?=
 =?iso-8859-1?Q?kgTxX9z0eclO5OqmYaigaJ4ijPIdEHRk4fzdM/KKSs9RtHpnVkoqndLqfd?=
 =?iso-8859-1?Q?KxIZSJ3AjNjpy6Jjp2o3RtNrMqYnCZl7Fo8zWJEz+DvzOjXdRy1FP6m+gh?=
 =?iso-8859-1?Q?lyBD7n/rcK6Na0kyTpjpAym5vybU6sioQIhw/Gz9jid4c5ahhyNPB5xZn0?=
 =?iso-8859-1?Q?uqQt7/cB5Znpkyde0SCtSrzRU6cm/9iepF6FKs+5evknWNKJAB5CIRlh4q?=
 =?iso-8859-1?Q?SJjJ7FgDgRKI5/vU22eVAaKauhqgVBZjsuF5ufSfMy0hflfFk0X7+/6CVz?=
 =?iso-8859-1?Q?QDFXmM/eg0NWw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7675.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04fd375-4559-4b36-75a4-08de3c4cc963
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 02:42:42.6994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+KrFlcO4M5TvTsk1PcqJZJXAd8zhSQTBuPi8Letl4JNNVDejU3fJcOPdZO72IoffMHA85q9G+fIE2iEUnkAEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
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

Hi Mario,=0A=
=0A=
This wouldn't work when we change compute and/or memory partitions. After a=
 partition switch we need to recreate all the nodes. If you have an instinc=
t machine you can try changing partitions =0A=
=0A=
$ rocm-smi --setcomputepartition CPX=0A=
=0A=
Best Regards,=0A=
Harish=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario =
Limonciello (AMD) <superm1@kernel.org>=0A=
Sent:=A0Wednesday, December 10, 2025 3:15 PM=0A=
To:=A0amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>=0A=
Cc:=A0Mario Limonciello (AMD) <superm1@kernel.org>=0A=
Subject:=A0[PATCH v2 2/3] amdkfd: Don't rebuild node tree when calling kfd_=
topology_update_sysfs()=0A=
=0A=
=0A=
There is no need to remove all the nodes and rebuild them.=A0 The content=
=0A=
=0A=
will be the same.=A0 Instead check whether the node was created and skip=0A=
=0A=
the creation.=0A=
=0A=
=0A=
=0A=
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>=0A=
=0A=
---=0A=
=0A=
=A0drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 ++----=0A=
=0A=
=A01 file changed, 2 insertions(+), 4 deletions(-)=0A=
=0A=
=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c=0A=
=0A=
index a0990dd2378c1..b65f29294e2d6 100644=0A=
=0A=
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c=0A=
=0A=
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c=0A=
=0A=
@@ -650,8 +650,8 @@ static int kfd_build_sysfs_node_entry(struct kfd_topolo=
gy_device *dev,=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t i, num_attrs;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct attribute **attrs;=0A=
=0A=
=A0=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 if (WARN_ON(dev->kobj_node))=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EEXIST;=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 if (dev->kobj_node)=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
=A0=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Creating the sysfs folders=0A=
=0A=
@@ -888,8 +888,6 @@ static int kfd_topology_update_sysfs(void)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 re=
turn ret;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
=A0=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 kfd_remove_sysfs_node_tree();=0A=
=0A=
-=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return kfd_build_sysfs_node_tree();=0A=
=0A=
=A0}=0A=
=0A=
=A0=0A=
=0A=
--=0A=
=0A=
2.43.0=0A=
=0A=
=0A=
=0A=
