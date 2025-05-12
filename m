Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC04C3ABC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 14:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A06A10E10E;
	Mon, 12 May 2025 14:25:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4+Tr0kO4";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A37B10E10E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 14:25:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLF2j6+j4ZdwvYAJ8lKocdPxgy0tm98et7QfLPz9Rzf8jN2N33AQR9qhoGdu31G35F5f3J7lHAXLMetEUVIfvjO4tvxy1/CUX3QC7v4fCjgmR9YkHMuksl6jfW/Lnx35QD8AVd5jExs2YgS4E7pGk4Wg41pBYMGJ1JaI6H+Y/nEDC7aawj29RXWXmeZitvu7HC0TBcp4Jb2F792Qc0zFvWi5g8MeCK3lCl841RwIbuUaLGjh58B7QXXLbrcGH/uxAGcnAGF0Rllk9lI/Vnp8LC2vTZkUTzNGmzqKt0isN7DpGLjsIqEcNE7C/G79IJRsvE8Do6Lp8DcEXUB8HjOILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BKC8zGcJ10G2Npw8u6xVUNf0SwNMP6MaJmRGCyFrwM=;
 b=IpcWm6J/nwBlgrK3h62qvZT/QfWcN8EtS5p+lPa4JzbDsXGDgCIxLmeIEo/eGiNhhuBjIeETKMspwErVU60NwLmWo8gW9iRSz2x38eOzUEInsLuh+Lg9zKYEmCcCSt8fJ4jKZXixOwBJtCG0UYryUlpmkikRh3h4gZCzsfHrcjMfe7xv+B2PxjVE2Cey0aao7FL/DXIeiLEo9rVztBkNj5+RBZ4a3SokYkZyy7XPBQplBMgsRgHEJHr6iaTr7uvXaPyv/hPZFBGPy4jpvC64eNp1Hye3HoAwRw0jqpBaElvCkkPX3OKYW9AKfvZCPdDvS7DXdH0069x73VcNKxksTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BKC8zGcJ10G2Npw8u6xVUNf0SwNMP6MaJmRGCyFrwM=;
 b=4+Tr0kO4eh867VdEmf8bqZCv95KT38FgpzWFPSd+Qz9j9+kSqj1N7HJoQ9ZF5vSZednI9pEHUnL5vbrkklajQyyKtaFrfr8q5iPTkk2rJbp+JeawhIOZzPJ7f0eIRJ4mXSGyUUvLK8Zg9xNy+bet+hLLYoReow3h7bbcTDvZa7s=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 14:24:56 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8699.012; Mon, 12 May 2025
 14:24:56 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
Thread-Topic: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
Thread-Index: AQHbvwppORSPpQjxKUyQ/qedfvajqbPIeo2AgAFbQFCABL1EgIAAcS3g
Date: Mon, 12 May 2025 14:24:56 +0000
Message-ID: <BN9PR12MB52577F8350CD5BD10EE4BB3CFC97A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250507044159.1006093-1-shiwu.zhang@amd.com>
 <PH0PR12MB8773D3ADD8CD6D40D46D7127F98BA@PH0PR12MB8773.namprd12.prod.outlook.com>
 <BN9PR12MB525754FD1CB54E142B15AD05FC8AA@BN9PR12MB5257.namprd12.prod.outlook.com>
 <PH0PR12MB87734DD27DEE9922EA0D4CCDF997A@PH0PR12MB8773.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB87734DD27DEE9922EA0D4CCDF997A@PH0PR12MB8773.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1edc1c76-3d9b-40da-b3cd-3400b86ebdb6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-08T09:30:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA3PR12MB7878:EE_
x-ms-office365-filtering-correlation-id: 264d9ccf-c693-464e-8405-08dd9160c506
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BrLHBh/73AtVVPqzJW2vNPjTpF5ELih7AikF0VYbMMlFOrywMZmI+gPCl2u3?=
 =?us-ascii?Q?H1zC73WULEJPoyDYhyVbJOOfPjN+2LDBO/EIRuINX70XiVWbAFZg1dt6SbDD?=
 =?us-ascii?Q?tJuMx1ANlMvODy/rHYy+Ng+/RSSvjn0H8UxCn8A3Xkrs2yBiK0hdEYw1ANNJ?=
 =?us-ascii?Q?7e6RBokUZbVPMExZWKS0Ms8YD8x5108PMbHChmqh+urWcAgU1fRW3QTdH0LK?=
 =?us-ascii?Q?OyLql5QAnO4P1o34C2onCBAskhxlK3qRSgDjy2csq9c97Arpmkx3COys6NgX?=
 =?us-ascii?Q?g1B2oHELc8+Y42SZcpOENFejxEbhZzB9HKN54g7cbME9Dy+7kg4Gap5uLip9?=
 =?us-ascii?Q?N0HEoSzg7nJAfYAVb/DRi1N8x6WyqqBvOG9vp6s8L7oaibApt47AVst40m6O?=
 =?us-ascii?Q?knDyzs1BU7OgEKRWQ9OnyS2wxroIK+sMLOIOlDGGSTGEr0/08Ykj9LkDv2rf?=
 =?us-ascii?Q?TE3rHTZBMfMOw01L2kKIVfY3eMw8WjwaX7C4hoLdSAWhXJUEIKool3Jjkspg?=
 =?us-ascii?Q?HcQo0g3UpvCNDzF7eif14W7TDxD2q3/iHLLFNULxeKzOrEy6CC4gJ/4F0y0R?=
 =?us-ascii?Q?g8cw3T0bWdsSRTjr/JR/tan/YUDNyq56FD7lBppVVPECAK9t8tEG7ZmMqFNO?=
 =?us-ascii?Q?W7IyQn3yhPoz8LCKUC2cdhHNHXKs4MHV2VIylHREu5SeTHXJ912pxDJLD826?=
 =?us-ascii?Q?lC71dHfnBv1/jXbR0ShzIOuxoBxwZjThwYlmb0g4Ynt8u7oWIAo8BS8Pvfs1?=
 =?us-ascii?Q?eLuRlzusjEsL6d3PfO+QXXi0LfbkIsP2LnJS73xOsZmaE4Le8FyJtWBAhRCB?=
 =?us-ascii?Q?Vm37fgzojAcRPFC8y8+0RmBaBGmOXZK34Jgx96QjuuqheQgU/4tv/DdMqFVk?=
 =?us-ascii?Q?qFyrk2sfGMtK9LrNfhsBS3srRLxAmzNpv5B/4/EX4mM+0vRehdBVZTomCkOB?=
 =?us-ascii?Q?WFvwdUdd9bdXjEQhwPrKFxVY2UqCiGrqaZkDu8JjzviCtgeT9KYzrSRD2xqS?=
 =?us-ascii?Q?pUamKsLWH9iPg8BmBJH4m8PMjnjqJ4NeR1jNJVmXyqE1jKdng3tnYzYmWpyE?=
 =?us-ascii?Q?Awtm12ZyOtcN+Y0C9kTBYgCCBTwML6Dkf1lYVeiqvwphpSbe93Nl3Sn6GHqX?=
 =?us-ascii?Q?cOvoNYkGnGFO+ogAxQElxlupCcELnkS/PNlFMrctWH26pkoi9qqtn1M2uzMY?=
 =?us-ascii?Q?1gl4rIzgS/q1co65Is8EPYeC6CZxk/yxIXAM11tQJdSlv6bROzpIjZnWzkY6?=
 =?us-ascii?Q?EnJY55A8th3O+eNP83BSlC9VJdm/+6ZNKReectYfsGbqiLvrdzGPPdy+uUZC?=
 =?us-ascii?Q?nHnTU1eAOmlFsr2OTLRybigeYIlPNjZ3N53J8cvDoBqgxcrx/NVonNMXD/eq?=
 =?us-ascii?Q?EMEChBL0Oo847PY7PzKkTI6t74qNJSuV6TO5zUa8Od3p+5G1H2BLOek7mRhj?=
 =?us-ascii?Q?Pe44Sxsq4mHY7nwwzBNxF5mF4IKjuioydaDWVjvZ3luHTCAB4C2KBwxV+22V?=
 =?us-ascii?Q?DiOx5SIM/ywqH4Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CkmhEa6jMxYXOCTgpNm1XAkF0chVzk5/FCjxsNAs/h76At2PdllGgWphSsBQ?=
 =?us-ascii?Q?bgH3zCkj2OYd2wmJGOL8rqYIt7EcBFSuzLRu7L/qvnhqWoML+MZ7KEkWm6mB?=
 =?us-ascii?Q?BSegHoCNgw4ftBhfrQCMO6XAsXwGJvDMjSMuZ+84cBf11YAiSNOVX8UOqftY?=
 =?us-ascii?Q?xySG8dS4D6mjxcEtEY6TcU2zHqCGjCecBEoyuLKyn2sDjT0tux+HYgmPZu5a?=
 =?us-ascii?Q?yr9Jh8UP04PNRZb2q1jPUPd0OKEpZpHhCtCr+riHU6ii23OPw1V2/2CttSdI?=
 =?us-ascii?Q?2glbjwBiPrYIDgXlFVm3eUZyqd7Ulc1DjLzA4K/Q6Zzxcr37UILjsRDXkSbf?=
 =?us-ascii?Q?LEmphjy3lBzuFGax4ETbOJfdQOz9IbQLWGiqKFnr2yEJyi5Z8Q6jiZs3Nxr5?=
 =?us-ascii?Q?iTDTcvOxrpuNDHkJyeUqb+kUUPQZtHrvdawng1tVfIc/nIiXb2q9RQr0AVD3?=
 =?us-ascii?Q?KBihk1TZs38KrFo8Mz1Ue8EPdKu40WV6jrkkInEQnITwK24kdLgLtGu1jjkb?=
 =?us-ascii?Q?IcpvN82YaQJHEP5+YFYVyFcrgv6krmVN6BY1fXqPlNmUajOPE1A8EvqjzEKf?=
 =?us-ascii?Q?3hulKRN+cE6zHKAi3Mxfxy1PVOFuoLw66Jc9PaAW/mtWuDzMV5yGwbKKOlhO?=
 =?us-ascii?Q?mtJV4SW71TLM3vjkTWcihf9hbtp4FN7Q5XYZdNDOzbm7nFSQjsvW2p++JkGP?=
 =?us-ascii?Q?13ecVEn2Fv/0uU3tW2i6LWGsWCQK3NFscc03Q1hN+UAHW5RFDBaFHYOo1/Sm?=
 =?us-ascii?Q?gJdDcPxtbqfwgvLHnehO+PblShqpgJnstoaWdOXZyeYEMqbTtSD79yK3Zf9u?=
 =?us-ascii?Q?0KiwKfyWKEdNkxCrtaeYvMhaQpOE/mcTrCn7mi6G+tc//kXzlV1HLR+mOtte?=
 =?us-ascii?Q?5aGuDYUEHopXKTIa1o39LGjx8Hp1ju1PpjdoBwcFZCVGubeL/eqe2jCDHYuf?=
 =?us-ascii?Q?PzlCp6lH10E6Va50ISQ8ShtvmJ4/K9OADtiNtksZfP4ahkPdWQY/+xkgOQml?=
 =?us-ascii?Q?tAy8uB6Gi+n0Jdncsv4sGYp32zl2eyoOAUHFc57T08fCQO4703HET8Wboy8Q?=
 =?us-ascii?Q?ouzTBlbq2RiJuB0/34M2o7n9h3jHinVX3mO6d2FaOkZuQpc95LrU6nlCULOT?=
 =?us-ascii?Q?T/SFsT1iywPBGHZtWRUzGe+AqggvFI5rXwo2OiZyS/76xTEaVwCJKsyO8QsI?=
 =?us-ascii?Q?2Gkd0sK3slpXV0H2aFiSjBj4o2lM8GwJCOqixQrMhpWRVmbo2Z4qDhV9JHAW?=
 =?us-ascii?Q?9pHOgD+vXC2NGPhSGEjLhwdVUVumbY9cFuPr9gcIujh2ljJiXRDbBi4Wa8qr?=
 =?us-ascii?Q?45Z+DqM9LTI07CXTI6mXpBEz0x1AW1ZGnPHY2rkKMRkYPthDuvANvQnBkphy?=
 =?us-ascii?Q?2W34JhlFAEZJLLvVmMtwDOZOUspH8z+npEoL5Y9FJdpnRCnyGXysocZUpAxz?=
 =?us-ascii?Q?dzZUMZajDHup3Pgy3oVzrbqUK/2YbbfnM+k4JnhqBSYsmZL5cb+ROUovYQGe?=
 =?us-ascii?Q?Q2OnbDaKosLrCD1meJJxoKG5X96pwHDd/Sb6EYexj9/fwvTli7NgAiDwhT1J?=
 =?us-ascii?Q?+lqwyZWykH8KfG3RR6E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264d9ccf-c693-464e-8405-08dd9160c506
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 14:24:56.4774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERg2+eMLu5wwrTEgeuZxb86Hq7BUnDA3J5e9X+NI+qUPf+KLItZYHUQ4FY8Tgzp981XIHgou1B0sYAPjuiIrLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878
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

I see. Thanks for clarifying.

#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2
#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3
#define C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
+#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO 0xf #define
+C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10 #define
+C2PMSG_CMD_SPI_GET_FLASH_IMAGE 0x11

[Hawking] I suggest putting above definition in amdgpu_psp.h, including SPI=
_GET_ROM_IMAGE and SPI_UPDATE_ROM_IMAGE. These command, and their related d=
efinitions are common across psp_v13 and psp_v14. There is no need to dupli=
cate them for every PSP IP generation.


+#if defined(CONFIG_DEBUG_FS)
+struct bo_address_triplet {
+       struct amdgpu_bo *bo;
+       uint64_t mc_addr;
+       void *cpu_addr;
+};
+#endif

[Hawking] bo_address_triplet is specifically used for dumping the spirom im=
age. I would suggest renaming it to spirom_bo, instead of more general name=
 like bo_address.

+       debugfs_create_file_size("psp_spirom_dump", 0444, minor->debugfs_ro=
ot,
+                               adev, &psp_dump_spirom_debugfs_ops, AMD_VBI=
OS_FILE_MAX_SIZE_B * 2);

[Hawking] does the caller need to access the entire amdgpu_device? Or shall=
 we consider exposing spirom_bo for this specific use case.

Regards,
Hawking

-----Original Message-----
From: Zhang, Morris <Shiwu.Zhang@amd.com>
Sent: Monday, May 12, 2025 14:39
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>;=
 amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump

[AMD Official Use Only - AMD Internal Distribution Only]

Hi hawking,
thanks for taking your time reviewing. simple_read_from_buffer() is just a =
linux wrapper around copy_to_user() and it handles the reading count and bu=
ffer position checking well so it can clean up the code a little bit. FYI.

And the one-time handshake with psp is put into the .open() for 1. Normally=
 user will call syscall open() only once but can call the read() multi time=
s and 2. The mutex operations include buffer allocation and handshake can b=
e put into one place so that the .read() and .release() can eliminate the n=
eed to request the mutex. Thanks!


> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Friday, May 9, 2025 2:20 PM
> To: Zhang, Morris <Shiwu.Zhang@amd.com>; Gao, Likun
> <Likun.Gao@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Morris,
>
> I will review the change later today. At first glance, it seems that
> some implementations are not included in the patch. For example, I
> couldn't find the implementation of simple_read_from_buffer. Did I miss s=
omething?
>
> +       return simple_read_from_buffer(buf,
> +                                      size,
> +                                      pos, bo_triplet->cpu_addr,
> +                                      AMD_VBIOS_FILE_MAX_SIZE_B * 2);
> + }
>
> Regards,
> Hawking
> -----Original Message-----
> From: Zhang, Morris <Shiwu.Zhang@amd.com>
> Sent: Thursday, May 8, 2025 17:34
> To: Zhang, Morris <Shiwu.Zhang@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Ping. Thanks!
>
> --Brs,
> Morris Zhang
> MLSE Linux  ML SRDC
> Ext. 25147
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Shiwu Zhang
> > Sent: Wednesday, May 7, 2025 12:42 PM
> > To: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun
> > <Likun.Gao@amd.com>; amd-gfx@lists.freedesktop.org
> > Subject: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
> >
> > Expose the debugfs file node for user space to dump the IFWI image on s=
pirom.
> >
> > For one transaction between PSP and host, it will read out the
> > images on both active and inactive partitions so a buffer with two
> > times the size of maximum IFWI image (currently 16MByte) is needed.
> >
> > Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     | 104 ++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h     |  17 ++++
> >  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c      |  40 +++++++-
> >  4 files changed, 161 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > index 4835123c99f3..bfa3b1519d4c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -2113,6 +2113,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *ade=
v)
> >       amdgpu_rap_debugfs_init(adev);
> >       amdgpu_securedisplay_debugfs_init(adev);
> >       amdgpu_fw_attestation_debugfs_init(adev);
> > +     amdgpu_psp_debugfs_init(adev);
> >
> >       debugfs_create_file("amdgpu_evict_vram", 0400, root, adev,
> >                           &amdgpu_evict_vram_fops); diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > index 6f9bcffda875..210a7bdda332 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -4185,6 +4185,110 @@ const struct attribute_group
> > amdgpu_flash_attr_group =3D {
> >       .is_visible =3D amdgpu_flash_attr_is_visible,  };
> >
> > +#if defined(CONFIG_DEBUG_FS)
> > +static int psp_read_spirom_debugfs_open(struct inode *inode, struct
> > +file *filp) {
> > +     struct amdgpu_device *adev =3D filp->f_inode->i_private;
> > +     struct bo_address_triplet *bo_triplet;
> > +     int ret;
> > +
> > +     /* serialize the open() file calling */
> > +     if (!mutex_trylock(&adev->psp.mutex))
> > +             return -EBUSY;
> > +
> > +     /*
> > +      * make sure only one userpace process is alive for dumping so th=
at
> > +      * only one memory buffer of AMD_VBIOS_FILE_MAX_SIZE * 2 is
> > consumed.
> > +      * let's say the case where one process try opening the file whil=
e
> > +      * another one has proceeded to read or release. In this way, eli=
minate
> > +      * the use of mutex for read() or release() callback as well.
> > +      */
> > +     if (adev->psp.spirom_dump_trip) {
> > +             mutex_unlock(&adev->psp.mutex);
> > +             return -EBUSY;
> > +     }
> > +
> > +     bo_triplet =3D kzalloc(sizeof(struct bo_address_triplet), GFP_KER=
NEL);
> > +     if (!bo_triplet) {
> > +             mutex_unlock(&adev->psp.mutex);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     ret =3D amdgpu_bo_create_kernel(adev, AMD_VBIOS_FILE_MAX_SIZE_B *=
 2,
> > +                                     AMDGPU_GPU_PAGE_SIZE,
> > +                                     AMDGPU_GEM_DOMAIN_GTT,
> > +                                     &bo_triplet->bo,
> > +                                     &bo_triplet->mc_addr,
> > +                                     &bo_triplet->cpu_addr);
> > +     if (ret)
> > +             goto rel_trip;
> > +
> > +     ret =3D psp_dump_spirom(&adev->psp, bo_triplet->mc_addr);
> > +     if (ret)
> > +             goto rel_bo;
> > +
> > +     adev->psp.spirom_dump_trip =3D bo_triplet;
> > +     mutex_unlock(&adev->psp.mutex);
> > +     return 0;
> > +rel_bo:
> > +     amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr,
> > +                           &bo_triplet->cpu_addr);
> > +rel_trip:
> > +     kfree(bo_triplet);
> > +     mutex_unlock(&adev->psp.mutex);
> > +     dev_err(adev->dev, "Trying IFWI dump fails, err =3D %d\n", ret);
> > +     return ret;
> > +}
> > +
> > +static ssize_t psp_read_spirom_debugfs_read(struct file *filp, char
> > +__user *buf,
> > size_t size,
> > +                             loff_t *pos) {
> > +     struct amdgpu_device *adev =3D filp->f_inode->i_private;
> > +     struct bo_address_triplet *bo_triplet =3D
> > +adev->psp.spirom_dump_trip;
> > +
> > +     if (!bo_triplet)
> > +             return -EINVAL;
> > +
> > +     return simple_read_from_buffer(buf,
> > +                                    size,
> > +                                    pos, bo_triplet->cpu_addr,
> > +                                    AMD_VBIOS_FILE_MAX_SIZE_B * 2);
> > + }
> > +
> > +static int psp_read_spirom_debugfs_release(struct inode *inode,
> > +struct file *filp) {
> > +     struct amdgpu_device *adev =3D filp->f_inode->i_private;
> > +     struct bo_address_triplet *bo_triplet =3D
> > +adev->psp.spirom_dump_trip;
> > +
> > +     if (bo_triplet) {
> > +             amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_ad=
dr,
> > +                                   &bo_triplet->cpu_addr);
> > +             kfree(bo_triplet);
> > +     }
> > +
> > +     adev->psp.spirom_dump_trip =3D NULL;
> > +     return 0;
> > +}
> > +
> > +static const struct file_operations psp_dump_spirom_debugfs_ops =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .open =3D psp_read_spirom_debugfs_open,
> > +     .read =3D psp_read_spirom_debugfs_read,
> > +     .release =3D psp_read_spirom_debugfs_release,
> > +     .llseek =3D default_llseek,
> > +};
> > +#endif
> > +
> > +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev) { #if
> > +defined(CONFIG_DEBUG_FS)
> > +     struct drm_minor *minor =3D adev_to_drm(adev)->primary;
> > +
> > +     debugfs_create_file_size("psp_spirom_dump", 0444, minor->debugfs_=
root,
> > +                             adev, &psp_dump_spirom_debugfs_ops,
> > AMD_VBIOS_FILE_MAX_SIZE_B * 2);
> > +#endif }
> > +
> >  const struct amd_ip_funcs psp_ip_funcs =3D {
> >       .name =3D "psp",
> >       .early_init =3D psp_early_init,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > index 3876ac57ce62..8fc4a7bb865e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > @@ -138,6 +138,7 @@ struct psp_funcs {
> >       int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_m=
c_addr);
> >       int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver)=
;
> >       int (*update_spirom)(struct psp_context *psp, uint64_t
> > fw_pri_mc_addr);
> > +     int (*dump_spirom)(struct psp_context *psp, uint64_t
> > + fw_pri_mc_addr);
> >       int (*vbflash_stat)(struct psp_context *psp);
> >       int (*fatal_error_recovery_quirk)(struct psp_context *psp);
> >       bool (*get_ras_capability)(struct psp_context *psp); @@ -322,6
> > +323,14 @@ struct psp_runtime_scpm_entry {
> >       enum psp_runtime_scpm_authentication scpm_status;  };
> >
> > +#if defined(CONFIG_DEBUG_FS)
> > +struct bo_address_triplet {
> > +     struct amdgpu_bo *bo;
> > +     uint64_t mc_addr;
> > +     void *cpu_addr;
> > +};
> > +#endif
> > +
> >  struct psp_context {
> >       struct amdgpu_device            *adev;
> >       struct psp_ring                 km_ring;
> > @@ -409,6 +418,9 @@ struct psp_context {
> >       char                            *vbflash_tmp_buf;
> >       size_t                          vbflash_image_size;
> >       bool                            vbflash_done;
> > +#if defined(CONFIG_DEBUG_FS)
> > +     struct bo_address_triplet       *spirom_dump_trip;
> > +#endif
> >  };
> >
> >  struct amdgpu_psp_funcs {
> > @@ -467,6 +479,10 @@ struct amdgpu_psp_funcs {
> >       ((psp)->funcs->update_spirom ? \
> >       (psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
> >
> > +#define psp_dump_spirom(psp, fw_pri_mc_addr) \
> > +     ((psp)->funcs->dump_spirom ? \
> > +     (psp)->funcs->dump_spirom((psp), fw_pri_mc_addr) : -EINVAL)
> > +
> >  #define psp_vbflash_status(psp) \
> >       ((psp)->funcs->vbflash_stat ? \
> >       (psp)->funcs->vbflash_stat((psp)) : -EINVAL) @@ -578,6 +594,7
> > @@ int psp_config_sq_perfmon(struct psp_context *psp, uint32_t
> > xcc_id, bool amdgpu_psp_tos_reload_needed(struct amdgpu_device
> > *adev);  int amdgpu_psp_reg_program_no_ring(struct psp_context *psp, ui=
nt32_t val,
> >                                  enum psp_reg_prog_id id);
> > +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
> >
> >
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> > b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> > index 17f1ccd8bd53..78f434f84c22 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> > @@ -79,6 +79,9 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");
> >  #define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2  #define
> > C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3  #define
> > C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
> > +#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO 0xf #define
> > +C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10 #define
> > +C2PMSG_CMD_SPI_GET_FLASH_IMAGE 0x11
> >
> >  /* memory training timeout define */
> >  #define MEM_TRAIN_SEND_MSG_TIMEOUT_US        3000000
> > @@ -710,7 +713,8 @@ static int psp_v13_0_exec_spi_cmd(struct
> > psp_context *psp, int cmd)
> >       /* Ring the doorbell */
> >       WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_73, 1);
> >
> > -     if (cmd =3D=3D C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
> > +     if (cmd =3D=3D C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE ||
> > +         cmd =3D=3D C2PMSG_CMD_SPI_GET_FLASH_IMAGE)
> >               ret =3D psp_wait_for_spirom_update(psp,
> > SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
> >                                                MBOX_READY_FLAG,
> > MBOX_READY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
> >       else
> > @@ -766,6 +770,39 @@ static int psp_v13_0_update_spirom(struct
> > psp_context *psp,
> >       return 0;
> >  }
> >
> > +static int psp_v13_0_dump_spirom(struct psp_context *psp,
> > +                                uint64_t fw_pri_mc_addr) {
> > +     struct amdgpu_device *adev =3D psp->adev;
> > +     int ret;
> > +
> > +     /* Confirm PSP is ready to start */
> > +     ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> > regMP0_SMN_C2PMSG_115),
> > +                        MBOX_READY_FLAG, MBOX_READY_MASK, false);
> > +     if (ret) {
> > +             dev_err(adev->dev, "PSP Not ready to start processing,
> > + ret =3D %d",
> > ret);
> > +             return ret;
> > +     }
> > +
> > +     WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116,
> > +lower_32_bits(fw_pri_mc_addr));
> > +
> > +     ret =3D psp_v13_0_exec_spi_cmd(psp,
> > C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO);
> > +     if (ret)
> > +             return ret;
> > +
> > +     WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116,
> > +upper_32_bits(fw_pri_mc_addr));
> > +
> > +     ret =3D psp_v13_0_exec_spi_cmd(psp,
> > C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D psp_v13_0_exec_spi_cmd(psp,
> > C2PMSG_CMD_SPI_GET_FLASH_IMAGE);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> >  static int psp_v13_0_vbflash_status(struct psp_context *psp)  {
> >       struct amdgpu_device *adev =3D psp->adev; @@ -898,6 +935,7 @@
> > static const struct psp_funcs psp_v13_0_funcs =3D {
> >       .load_usbc_pd_fw =3D psp_v13_0_load_usbc_pd_fw,
> >       .read_usbc_pd_fw =3D psp_v13_0_read_usbc_pd_fw,
> >       .update_spirom =3D psp_v13_0_update_spirom,
> > +     .dump_spirom =3D psp_v13_0_dump_spirom,
> >       .vbflash_stat =3D psp_v13_0_vbflash_status,
> >       .fatal_error_recovery_quirk =3D psp_v13_0_fatal_error_recovery_qu=
irk,
> >       .get_ras_capability =3D psp_v13_0_get_ras_capability,
> > --
> > 2.34.1
>
>


