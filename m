Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706D5E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 21:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18BF810E189;
	Fri, 10 Jan 2025 21:23:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fQ7JUtIm";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1026710E189
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 21:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cW3+kBQeg5nyooO0h8e2Khl1DcsI1XwxL4vA/it2G5imOzxb3lKsJ6DUE83C3BXf1ny5W4td5q3LyEPlJ47ZvT85XLkKw955YhI/8DZpFnmLy6T+taR6nXuoi9aCCnG6gK9nhaa37gXEF97tRMFk6c4HfWl3j4UeOWFSnUxmivUoeSSfUFIw/x3ngKb9pqxareluR7yn+YTJhfF4YhM9UtCCJ6gi4Yo5d7uMLBGo3GpJUX6ituRxso3Amsf4+wA/gg9bw26ztJ+RHpHXcPqC9u7WaTxqFnKN1S/BKmDCOPMUrTTRAVr9RtRC4wpi9ti3IHJYBOS64c1AnFx8VOL/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j23IZlGVw0JkLb/NX6omrPYF1+BB+cCWTq7HY3MfCxM=;
 b=gB1dHeQLZ7jpiHT0jfDGxAROoDlH+FZyrA0EzXsrNnFpBkHr/jPTBjjJsnyF25mU9pBHBk02VksN6MHmmvSE4EceJ7sjdb5yNj43zjgRHTCamJ+qI3vUhWcO5ZVEfnykmrz7tMTViq0WX+1G7j2zOFJywIA0H0wms7MO8AbmuB/OFE2xRUxNbhg3v1ApvaYazb0j7TdW2Tmz/awuavvpyDhOWyk/Gs1ygiMdy8RkT4qCCFefbIyqaGcFL745G2fFrjXIOZSL5e3TELOHBCBcKsQQKfcoDbhTqLg/qFw6jzLeQ7fNjlIWNq0oYxmkBCIFr6GE6p/aPFVeRpY218h7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j23IZlGVw0JkLb/NX6omrPYF1+BB+cCWTq7HY3MfCxM=;
 b=fQ7JUtImN1j/l5bS8lse2F3+oY1pAU03DztT/Uh7w2Kq+m8j/uATQCxIq5MuhMcFqjGz3r1IUK7FKuujuOCGMGDjPJHNLsgVxjQAh6Z5nOwYgBeQxA5js85CCi523VaObeCJ+6F2EhVtDsrP+ACL+FJ22AApEpXF6ND7BLjUc1M=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 21:23:27 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 21:23:27 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
Thread-Topic: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
Thread-Index: AQHbYggg7TRtauGCh02VRE8z9Mjnf7MN908AgACHIuCAAN/YAIAAy7mwgAALhACAAErsIA==
Date: Fri, 10 Jan 2025 21:23:27 +0000
Message-ID: <CY8PR12MB74358329999D20A4899DA18D851C2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250108200121.2808908-1-jonathan.kim@amd.com>
 <0ab5d4aa-ac2c-4108-99e5-902f73f827bb@amd.com>
 <CY8PR12MB7435645F2AB787B7BC57BB0A85132@CY8PR12MB7435.namprd12.prod.outlook.com>
 <f7a71dc8-7643-431e-8c92-ade74619ef2c@amd.com>
 <CY8PR12MB743599F7DD753244994863C6851C2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <9600acc2-b6fc-4c22-a9d6-061250cf75e0@amd.com>
In-Reply-To: <9600acc2-b6fc-4c22-a9d6-061250cf75e0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=372353e8-d151-4dbd-80a2-506c0b397f14;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-10T21:18:08Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|CY5PR12MB6058:EE_
x-ms-office365-filtering-correlation-id: 49516b1d-fae8-4875-c842-08dd31bd0608
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZXFyYTMrYnZKVE5MS0d0bCsrcnNWN203d0RmR0RVcFd0eCt5NDE5UGJpbmZD?=
 =?utf-8?B?VW1pNWxjZm9SQlB4UFhuL1RJNE5tY0haeExaUjQ4T29JcHIwWFpuNVVod3VO?=
 =?utf-8?B?RWFUS20zdkVBVEE5aHZCbzdic29DZTcwTXArWVROSkh3L2VLV2M0bnhnSHhn?=
 =?utf-8?B?OVRFWGtoRy9DQ3VZTVlrbHc3emx4M05TWExhcllaKzM4Q2lMTzFKQXZIYWRJ?=
 =?utf-8?B?ZzV0SEN0YnpmK1Z4a0l3MVpEaE9SdlZRTkpVRldNVWE3WXIzZGJkQTVxbUJZ?=
 =?utf-8?B?a1lUdkZmZmx6SkdaNkpKTzFIL1ZiR3NUVTNsQ0dYcUJxa0FsRm1lOXhtM01J?=
 =?utf-8?B?VHg4U0RLaWRvQzNrNTc0T1FqMlpCSjRkNVlaNitiNHJtTEpCcStFSEEwQzda?=
 =?utf-8?B?OUlYK2UvZXNnQnRNWFhpSmFiTkxaM1NBWGt3VUtiUjVadTFGNFdEKytCWHha?=
 =?utf-8?B?YmJLYlV6VVZUUXp6V2tXM00zejZGQTIxS0FaRUo2R2JFbmhFYmZYRFdxS2Jp?=
 =?utf-8?B?YkZDZTBwUzlJMlpGemRZQnhwTjg2Mm0rUUVMenFuWFNBZlVwOXhWaDhxdXlQ?=
 =?utf-8?B?SzJidGQ3bEQrcmlZUFlGSGxVT2Z3UFppTzhwdVUyU1ZKUENWL3FaWXM4NmJM?=
 =?utf-8?B?a1RpczJwbUJINUFpRUh4Z1VKTXRPUnc5Q3cyVUZKTkNpdHRTckdLTmFLUWhi?=
 =?utf-8?B?dVdCVm9LbnFKc0p4eGZyR01pZEM5YXpCbjlzUk1nQzd5bkhiazFjQ21VRDVt?=
 =?utf-8?B?Wkl0eGNRczd5ZFdoQzlRYkJaaFMwN0Q4MnZPUXkxTXVsU3lpVW85ekNZSWcv?=
 =?utf-8?B?d0w2YWFnNGdIZU5PUWp3MSsvRFFUZTU2Z3lWemVZaU16ZU0zcWlYd0J5YXBs?=
 =?utf-8?B?MmFCYXhORVRkc2VjVFJqaVYvdGlnQzVUTnN0Ym83NlhheldadGVIUEoxWlhX?=
 =?utf-8?B?Z3VYL3pZT1hDb2J3ZFN6ekd4dXZwVS9kMEFmRTFtVk95cjJvZFV5WWVJWEQv?=
 =?utf-8?B?MVQrYlpzWk8vUWxMdm5WaldEZWRIRmo5SU9RZFdWbERScGJ1b0NDRUJxLy81?=
 =?utf-8?B?K2VkTGVQRi9MVEdaaEJmY01HR1IwWWRFRG9aVnpZUGEwMkZCZC8raG9QaUN4?=
 =?utf-8?B?YjZaZWt6bTZwQTViMW53cU9uZXZKU3ZHanZFcys0WnBGL3RWZ0Z0VEY5aVZm?=
 =?utf-8?B?Mk1XTVQwYmx6M0orbGV5YW5kV3hYb2dOR1ZWOGx2blRXTWlIQWZ5alBneDha?=
 =?utf-8?B?WDFvRDhvc3lGclR0RkpuTTdkcUJ4RDRkSmhLOG1IRHFwNTgzc2NGUWRGQmlr?=
 =?utf-8?B?d2o0Qkl6bkhTbjNROXMxWXJFVW1SeFFCWHYrNk5LRm8wRXZodkczYXFUVmVE?=
 =?utf-8?B?MzUrQS9UN3JLOGhMZndvakZPQVFSeVJhd25YMlF4RDhpVmtRaUtyYk1uT3ky?=
 =?utf-8?B?Z0NsaGx2WUdKNng2VnNvK0hyNGdsZjBUWk5rU2N2L1RNTHZ4QWp2ZFFzSlEv?=
 =?utf-8?B?VTIzR0phL3pSTGJsdVN3bFU0SHYvalgrNmRqamF5UEViNm9Ubk1NYm5NdkQ3?=
 =?utf-8?B?ODlTeWI3ZVg2YjJTYWpFYWRzNkNtejdBYi82SUtGSGtDRTdSKzJ5NnEwNXl5?=
 =?utf-8?B?V2ZOWlErc2hXTEoybC93M2VkYXhXelErL3FNc2J3TEZCS0V1cXBTQlNmcUFW?=
 =?utf-8?B?WkpWZ3c5RTk5c0lkNlVoWmlOUDdnNXkxT25nbUtTRFdWNFk5U1RiSHdYVGFp?=
 =?utf-8?B?R1JLK242NlY1anV6MnpXazVmWEhFdE5Ob2xqWFdyTHdkYWhmaWVOUG8wUUEy?=
 =?utf-8?B?a29XVk9sS2pJWjVmU1FtY2k3dWwvUUYzeGFJTVRYVlkrV09xc096VlYrNVpL?=
 =?utf-8?B?YXpaaHUyZ3FZY2VyWm82VURpZTRxdEdBeUFQVEtGZHByUHBhNkE0VFU5bGhi?=
 =?utf-8?Q?i8Di94hqIrqBgrI39K2NxXHRYfmC+4Gp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VldhSWhHUFN3SWN2aHRNOVVLTE43dGo3SGc0SXpFL201aitjaTFBRGVXazBE?=
 =?utf-8?B?M0xhSEp1V0ljMGRwK0VJejdHZ29NTDVIMDB4MVpuN2JPRDB5UHVlc2Y0NFZr?=
 =?utf-8?B?ME5kMUtMQ1ZIWmRNRnNLL2UwUXFKczVPU0c0UWl5YlRuWjlUNXE5REYvZTlZ?=
 =?utf-8?B?WWVyTWJuM25kN0RxOVhpVWZGUlNnREF5VWhmdDJwaVAwSlZVdHA0SmhaalMz?=
 =?utf-8?B?TTVSOTlmVWFRNHQwUlBXVk8xSHV1NTZuTmR6VzdRRFZDUzhvYnVWdUZaZ0Ji?=
 =?utf-8?B?Mi84YXl4dHExWHNoVk9DSXc4QnNTUElZMFZtZVc0TGJXaURWZHNwUUo0YTlW?=
 =?utf-8?B?UWRxTm5JRUN3WUlwc3c3V3JKeDZ3Z0Y0K01UTlVhNWJIQjZzOFkxVlNyc1hu?=
 =?utf-8?B?S2ROYzI4Y1EwaEo5V1hKZDliRkRaZWVqZUlFTmZyZWFZRFA0QzI5UEt1Y3Zv?=
 =?utf-8?B?TU9VbVdmWTVkL1QxUzdLV245Y0pMd1I1SnlpMWlhM2tPZEpzMEZEUS8yNVo5?=
 =?utf-8?B?RU9CRG5kdEx1YUM0elI4VEhzYkxsVmZHOTdPS3dYeTg1c01SM1RtQmIxaHNr?=
 =?utf-8?B?WnhxNTl0bWttdEw3a0ZReFZaOVVLYVNGT1Q3bVE4Q2FLTnczdDBRdXcydDhv?=
 =?utf-8?B?WStEQ09VQ2ZDZC9mSy91ZUgzN0Zha2FqdXJJeURnaFZUL0xlKzBnN0oyZStR?=
 =?utf-8?B?R3E2c0prREE2V3A3bDdDM1o2SlAvT1B6QVNrbitmcmxoRmI3aHd1a0NaM3VF?=
 =?utf-8?B?WDNRdGIyeGZiUlQvUWpQL1JOekZjWG5HamJIOFpKL0ZHYkJiQndPMlFrT0Rk?=
 =?utf-8?B?N0d3SndlWStCN0k2QTVCRWh6ZnZqdyt6bjBTTDJBcFg0Z0xtSjJNZ2g3WFZ0?=
 =?utf-8?B?RURScDBqUkpuL2xWSnlXVHBCQzZJQk80L05wMklxMzVkZWVETDczM1RreVJH?=
 =?utf-8?B?MFBWSWJoZ0dYVEo0WU9yVi92aitNQ1VGd2NoQW51VjQ4Z3hkU2gzUFd3dDhq?=
 =?utf-8?B?YzExRGZEMlovTW5kUkFYVWwrSCt5NmZXQnpadG9aK3k5enBUMzhkVWx4L0pQ?=
 =?utf-8?B?WmtyK29JaVBQMWJmWnVzVGM3SEVZeEpyVW1oWDFMWmZzdXBpenU2QWNUQnlk?=
 =?utf-8?B?eC9MMFQ0VUhmZ1BSMkNTdm1qeTFqVFZxNmlSZ1NYTW1CRzBmQmw0L1ZEa3I4?=
 =?utf-8?B?cUJrMjREZmgwSjhaL09ZZFAxL3NjKzRiSWJTL201Q1FDQnNrU25ENCs2U21O?=
 =?utf-8?B?L0VrMW5tMm5QdjlNdWd1aVZNWGY1d1Qxc2pKY2x5N0ZWMU02WnRmOXVvdTA4?=
 =?utf-8?B?WVBCLzlHY1JpVU9EZ2xSUy9meTgvUi9CM0xFOEozQTNyZFVkcjVLNGMrMzBR?=
 =?utf-8?B?Z05yRCsxYkE4alZ2RGZYNTJ0SlVCVGs4bjRBOU5mVktzSnljemlhUHErbldk?=
 =?utf-8?B?NkE2bi83SUZXSE9jK3RHVGVzVzB4cXhoalB2NVcyZkVRYTBqMmFqSkpuazVL?=
 =?utf-8?B?TmRPK3dSUmF6L3NQS1lYbFFTZmJJNk5Qc214N3pLYUVLcmliTzhOSnlsRlV1?=
 =?utf-8?B?NWhiNWVIbUY0b3FoemlXRVFYS0wzajNBcFVVcWtHNmhKNTFOcTlMNjFIZmcx?=
 =?utf-8?B?TjlqWk9lcjJyUlplTy9qVU5za2N3ZFFPOHZBcFNwQUM4SlQrU1dSaUx5b0Jx?=
 =?utf-8?B?UTc1b21WUEZzY3dTU2sxcnhjV283aXVpUEJ4bzVDbGxCR1dPWlVpU3FyZVhM?=
 =?utf-8?B?dGFNMTRNMkt5WC9aS2lJb1FjVU5FVkVaTjdPN2VmQklDNXBSYnF5dVNxME90?=
 =?utf-8?B?c0xpbTloWUhpM25ncHpVajJhQWFmd2VmaS9rY0U0ZzN5RXNUaVUxbSs0OWEz?=
 =?utf-8?B?RUFGMXBrTjhlRnh3TTVkU0s0cktQUzM4cWtnZUJJY1pEMlJFc1psZUNnVFk2?=
 =?utf-8?B?RXlvYStpbE9YZE9kVDRhNUNlVSt2cllPVkYvZHhFVDlmc1Z2OFZZc2tidkIr?=
 =?utf-8?B?blhHTE5GVElITDZ4dUFWUUtkVyt2VmRNd3N6Nzkxa1ZFNEZGbUgrNE9jMTd4?=
 =?utf-8?B?REg2dy9OTnVOa1lOTlREellDa0NpLzgrU0o1SFFPMnBJczQrVEFIM1JxL0N5?=
 =?utf-8?Q?PLmY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49516b1d-fae8-4875-c842-08dd31bd0608
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 21:23:27.6080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4NMQ9mrk5BTG/QpL9vKahXsTRdUwd21582U4tWap4wG0h8iBj/QH6S0nL7IkCJC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgMTAsIDIw
MjUgMTE6MjkgQU0NCj4gVG86IEtpbSwgSm9uYXRoYW4gPEpvbmF0aGFuLktpbUBhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IEthc2l2aXN3YW5hdGhhbiwgSGFy
aXNoIDxIYXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGRybS9hbWRncHU6IGZpeCBncHUgcmVjb3ZlcnkgZGlzYWJsZSB3aXRoIHBlciBxdWV1ZSBy
ZXNldA0KPg0KPg0KPg0KPiBPbiAxLzEwLzIwMjUgOTo0MyBQTSwgS2ltLCBKb25hdGhhbiB3cm90
ZToNCj4gPiBbUHVibGljXQ0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+ID4+IFNlbnQ6IFRo
dXJzZGF5LCBKYW51YXJ5IDksIDIwMjUgMTA6MzkgUE0NCj4gPj4gVG86IEtpbSwgSm9uYXRoYW4g
PEpvbmF0aGFuLktpbUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4g
Pj4gQ2M6IEthc2l2aXN3YW5hdGhhbiwgSGFyaXNoIDxIYXJpc2guS2FzaXZpc3dhbmF0aGFuQGFt
ZC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCBncHUgcmVj
b3ZlcnkgZGlzYWJsZSB3aXRoIHBlciBxdWV1ZSByZXNldA0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+
PiBPbiAxLzkvMjAyNSA4OjI3IFBNLCBLaW0sIEpvbmF0aGFuIHdyb3RlOg0KPiA+Pj4gW1B1Ymxp
Y10NCj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9t
OiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiA+Pj4+IFNlbnQ6IFRodXJzZGF5
LCBKYW51YXJ5IDksIDIwMjUgMToxNCBBTQ0KPiA+Pj4+IFRvOiBLaW0sIEpvbmF0aGFuIDxKb25h
dGhhbi5LaW1AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+Pj4g
Q2M6IEthc2l2aXN3YW5hdGhhbiwgSGFyaXNoIDxIYXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5j
b20+DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IGdwdSByZWNv
dmVyeSBkaXNhYmxlIHdpdGggcGVyIHF1ZXVlDQo+IHJlc2V0DQo+ID4+Pj4NCj4gPj4+Pg0KPiA+
Pj4+DQo+ID4+Pj4gT24gMS85LzIwMjUgMTozMSBBTSwgSm9uYXRoYW4gS2ltIHdyb3RlOg0KPiA+
Pj4+PiBQZXIgcXVldWUgcmVzZXQgc2hvdWxkIGJlIGJ5cGFzc2VkIHdoZW4gZ3B1IHJlY292ZXJ5
IGlzIGRpc2FibGVkDQo+ID4+Pj4+IHdpdGggbW9kdWxlIHBhcmFtZXRlci4NCj4gPj4+Pj4NCj4g
Pj4+Pj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gS2ltIDxqb25hdGhhbi5raW1AYW1kLmNvbT4N
Cj4gPj4+Pj4gLS0tDQo+ID4+Pj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
YW1ka2ZkX2dmeF92OS5jIHwgNiArKysrKysNCj4gPj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKykNCj4gPj4+Pj4NCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMNCj4gPj4+PiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMNCj4gPj4+Pj4gaW5kZXggY2M2
NmViYjdiYWUxLi40NDE1NjgxNjNlMjAgMTAwNjQ0DQo+ID4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMNCj4gPj4+Pj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYw0KPiA+Pj4+PiBA
QCAtMTEzMSw2ICsxMTMxLDkgQEAgdWludDY0X3Qga2dkX2dmeF92OV9ocWRfZ2V0X3BxX2FkZHIo
c3RydWN0DQo+ID4+Pj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPj4+Pj4gICAgIHVpbnQzMl90
IGxvdywgaGlnaDsNCj4gPj4+Pj4gICAgIHVpbnQ2NF90IHF1ZXVlX2FkZHIgPSAwOw0KPiA+Pj4+
Pg0KPiA+Pj4+PiArICAgaWYgKCFhbWRncHVfZ3B1X3JlY292ZXJ5KQ0KPiA+Pj4+PiArICAgICAg
ICAgICByZXR1cm4gMDsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiAgICAga2dkX2dmeF92OV9hY3F1aXJl
X3F1ZXVlKGFkZXYsIHBpcGVfaWQsIHF1ZXVlX2lkLCBpbnN0KTsNCj4gPj4+Pj4gICAgIGFtZGdw
dV9nZnhfcmxjX2VudGVyX3NhZmVfbW9kZShhZGV2LCBpbnN0KTsNCj4gPj4+Pj4NCj4gPj4+Pj4g
QEAgLTExNzksNiArMTE4Miw5IEBAIHVpbnQ2NF90IGtnZF9nZnhfdjlfaHFkX3Jlc2V0KHN0cnVj
dA0KPiA+PiBhbWRncHVfZGV2aWNlDQo+ID4+Pj4gKmFkZXYsDQo+ID4+Pj4+ICAgICB1aW50MzJf
dCBsb3csIGhpZ2gsIHBpcGVfcmVzZXRfZGF0YSA9IDA7DQo+ID4+Pj4+ICAgICB1aW50NjRfdCBx
dWV1ZV9hZGRyID0gMDsNCj4gPj4+Pj4NCj4gPj4+Pj4gKyAgIGlmICghYW1kZ3B1X2dwdV9yZWNv
dmVyeSkNCj4gPj4+Pj4gKyAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4+Pj4+ICsNCj4gPj4+Pg0K
PiA+Pj4+IEkgdGhpbmsgdGhlIHJpZ2h0IHBsYWNlIGZvciB0aGlzIGNoZWNrIGlzIG5vdCBpbnNp
ZGUgY2FsbGJhY2ssIHNob3VsZCBiZQ0KPiA+Pj4+IGZyb20gdGhlIHBsYWNlIHdoZXJlIHRoZSBj
YWxsYmFjayBnZXRzIGNhbGxlZC4NCj4gPj4+DQo+ID4+PiBJIGRvbid0IHRoaW5rIGl0IHJlYWxs
eSBtYXR0ZXJzLiAgV2UncmUgZ29pbmcgdG8gaGF2ZSBkaWZmZXJlbnQgcmVzZXQgdHlwZXMgaW4g
dGhlDQo+IGZ1dHVyZQ0KPiA+PiB0aGF0IG15IGNvbWUgZnJvbSBkaWZmZXJlbnQgY2FsbGVycy4N
Cj4gPj4+IEl0J3MgcHJvYmFibHkgZWFzaWVyIHRvIHJlbWVtYmVyIHRvIHB1dCB0aGUgYnlwYXNz
IHdoZXJlIHRoZSByZXNldCBpcyBhY3R1YWxseQ0KPiA+PiBoYXBwZW5pbmcuDQo+ID4+Pg0KPiA+
Pg0KPiA+PiBJZiBJIHdhbnQgdG8gZGVmaW5lIHNvbWV0aGluZyBsaWtlIGFtZGdwdV9ncHVfcmVj
b3Zlcnk9MiAoZG9uJ3QgZG8gcXVldWUNCj4gPj4gcmVzZXQgYnV0IHBlcmZvcm0gb3RoZXIgcmVz
ZXRzKSwgdGhlbiBpdCBtYXR0ZXJzLg0KPiA+DQo+ID4gSSBkb24ndCBnZXQgd2h5IHRoYXQgbWF0
dGVycy4NCj4gPiBUaGlzIGNhbGxiYWNrIGFsb25lLCBmb3IgZXhhbXBsZSwgY2FsbHMgMiB0eXBl
cyBvZiByZXNldHMgd2l0aGluIGl0c2VsZiAocXVldWUgdGhlbg0KPiBwaXBlKS4NCj4gPiBJZiB5
b3Ugd2FudGVkIHBhcnRpYWwgcmVzZXRzIGJldHdlZW4gcXVldWUgYW5kIHBpcGUgaW4gdGhpcyBj
YXNlLCB5b3UnZCBoYXZlIHRvDQo+IGJyYW5jaCB0ZXN0IHdpdGhpbiB0aGUgY2FsbGJhY2sgaXRz
ZWxmLg0KPiA+IEdQVSByZXNldCBieXBhc3MgY2hlY2tzIGFyZSBpbnZpc2libGUgdG8gdGhlIEtG
RCBzZWN0aW9uIG9mIHRoZSBjb2RlIGFzIHdlbGwuDQo+ID4NCj4gPj4NCj4gPj4gU2luY2UgdGhp
cyBpcyBhIGNhbGxiYWNrLCBrZWVwaW5nIGl0IGF0IHRoZSB3cmFwcGVyIHBsYWNlIG1heSBiZSBt
b3JlDQo+ID4+IG1haW50YWluYWJsZSByYXRoZXIgdGhhbiBrZWVwaW5nIHRoZSBjaGVjayBmb3Ig
Z2Z4MTAvMTEvMTIgZXRjLg0KPiA+DQo+ID4gTWF5YmUgbm90LiAgTUVTIGlzIHByZWVtcHRpb24g
Y2hlY2tzIGFyZSBub3QgbGlrZSBNRUMgcHJlZW1wdGlvbiBjaGVja3MgYXQgYWxsLg0KPiA+IEFu
ZCB3ZSBwcm9iYWJseSBkb24ndCB3YW50IHRvIGphbSBvdGhlciBmdXR1cmUgSVAgcmVzZXRzIGlu
dG8gYSBzaW5nbGUgY2FsbGVyLg0KPiA+IElmIHlvdSBsb29rIGF0IHRoZSBrZmQya2dkIGNhbGxi
YWNrcywgbW9zdCBhcmUgcHJldHR5IG11Y2ggY29weSBhbmQgcGFzdGUgZnJvbSBvbmUNCj4gZ2Vu
ZXJhdGlvbiB0byBhbm90aGVyLg0KPiA+IEkgZG9uJ3Qgc2VlIGhvdyBwdXR0aW5nIHRoZSB0ZXN0
IGluIHRoZSBjYWxsYmFjayBtYWtlcyBpdCBsZXNzIG1haW50YWluYWJsZS4NCj4gPg0KPg0KPiBN
eSB0aG91Z2h0IHByb2Nlc3Mgd2FzIHRoaXMgY291bGQgYmUgcHV0IGluIC0gcmVzZXRfcXVldWVz
X29uX2h3c19oYW5nDQo+IGFuZCBhbnl0aGluZyBzaW1pbGFyIGhhbmRsZXMgTUVTIGJhc2VkIHF1
ZXVlIHJlc2V0cy4gV2hhdCB5b3UgYXJlIHNheWluZw0KPiB0aGVyZSB3b24ndCBiZSBhbnl0aGlu
ZyBsaWtlIHJlc2V0X3F1ZXVlX2J5X21lcygpIGZvciBNRVMgYmFzZWQgcmVzZXRzLg0KPiBJcyB0
aGF0IGNvcnJlY3Q/DQoNCk5vIHRoZSBvcHBvc2l0ZS4gIEJ1dCBub3cgd2UnZCBoYXZlIHRvIHJl
bWVtYmVyIHRvIHB1dCBpdCBpbiAyIHBsYWNlcyB3aGVyZSB0aGVyZSdzIHN0aWxsIG5vIHZpc2li
bGUgdGVzdCBmb3IgZ3B1IHJlc2V0IGJ5cGFzcyBpbiB0aGUgc2FtZSBmaWxlLg0KU0RNQSByZXNl
dHMgYXJlIGFsc28gYmVpbmcgaW1wbGVtZW50ZWQgYW5kIHdpbGwgcHJvYmFibHkgaGF2ZSB0byBi
ZSBjYWxsZWQgaW4gZGlmZmVyZW50IHBsYWNlcyBpbiB0aGUgS0ZEIGFzIHdlbGwuDQpXZSBjYW4g
bG9vayBhdCBjb25zb2xpZGF0aW5nIHRoaXMgbGF0ZXIgYXMgbW9yZSBkZXZpY2VzIGFuZCBJUHMg
Z2V0IGRvbmUgaWYgaXQgbWFrZXMgc2Vuc2UgdG8gYWJzdHJhY3QgdGhpcyBzdHVmZi4NCk15IHBv
aW50IGlzLCB0aGUgY2FsbGJhY2sgZG9lcyB0aGUgcmVzZXQgYW5kIHJldHVybnMgYSByZXNldCBz
dGF0dXMuDQpCeXBhc3NpbmcgYnkgZmFpbCByZXR1cm4gc2VlbXMgZWFzaWVyIHRvIHJlbWVtYmVy
IGFuZCBsZXZlcmFnZS4NClRoYXQgYmVpbmcgc2FpZCwgcHV0dGluZyB0aGUgdGVzdCBpbiBocWRf
Z2V0X3BxX2FkZHIgd2FzIHByb2JhYmx5IG92ZXJraWxsLCBidXQgSSBkb24ndCB0aGluayBhbnlv
bmUgcmVhbGx5IGNhcmVzIHRvIHVzZSBpdCB3aXRoIGdwdSByZWNvdmVyeSBvZmYgb24gaXRzIG93
biBhdCB0aGUgbW9tZW50Lg0KDQpKb24NCg0KPg0KPiBUaGFua3MsDQo+IExpam8NCj4NCj4gPiBK
b24NCj4gPg0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+IExpam8NCj4gPj4NCj4gPj4+IEpvbg0K
PiA+Pj4NCj4gPj4+Pg0KPiA+Pj4+IFRoYW5rcywNCj4gPj4+PiBMaWpvDQo+ID4+Pj4NCj4gPj4+
Pj4gICAgIGtnZF9nZnhfdjlfYWNxdWlyZV9xdWV1ZShhZGV2LCBwaXBlX2lkLCBxdWV1ZV9pZCwg
aW5zdCk7DQo+ID4+Pj4+ICAgICBhbWRncHVfZ2Z4X3JsY19lbnRlcl9zYWZlX21vZGUoYWRldiwg
aW5zdCk7DQo+ID4+Pj4+DQo+ID4+Pg0KPiA+DQoNCg==
