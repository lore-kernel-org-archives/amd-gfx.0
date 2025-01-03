Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE44E77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 13:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C22010E348;
	Fri,  3 Jan 2025 13:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EwZFi8c5";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 008AD10E348
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 13:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AniqnLUhMBAW074YYKtyfs2jtB8s+yIjj54u138eneIPGnc+hLs2uJFgKYuAI42d5VeWmR73gh9/eSdHNGUGChwKXj2couGXuu8nbDTml0QKsX0uQzPgxHYQUn9LoifPAZ7Q8B6L7pSKSCyaSJ4lXbOvJ3KYo7jnwq8EwYssRqwKKuH99v03GWOC03H+vsls072WjQNCm3OUVT7MzOXKicOpCvak0zoDXVut6nUeqHnRuxXIUJ6kGyVd0sJ6jrzWz87bRIeh44/L3v2jn7T0nshefdWw08NagzAYFsUErdxX51azOJsOsgvC6on1Fg3jmJH0c493rtACakJpLgwOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHsV0Au7z4iibtgcw/t1dsb7y46Oq4e7J39Zev25XrY=;
 b=hHmUyhBrHi3ikAItOcUxMKyr3smRTgTTsn1E9EJMr+3HL/gYtIjZFZo70DbWKM9YqK+Qlub4/a3UQRAhs51AM+Y0mmYjkLnp87Qdo64fSUpD/deL7DF82Er1AmJtMwl2QAutU7XV7Xhq9hRhicbUiy2knMgHhmShtiumMIDjVYNDhVxLI15zYtPwK5pmTuqmQHDtjVeTB2ZY2c86/Mgy7y+ydCvNMWiUrbczkmDSblCK97Cf2JcT3UlDIg4TKi9ekzy9a+1j1bHPjuaabqEqY/5KiUW4Wqw5F2/wGtoUa12ah5pDiBaTeH5YIAuzYaKQ6Cmj1OcAtty+B8LDHo5byw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHsV0Au7z4iibtgcw/t1dsb7y46Oq4e7J39Zev25XrY=;
 b=EwZFi8c5/wP6TJ7lwFM1sneCjAdbZdXCJxQe+zGikHj4KNZ8oRfrEIe3jNCvlkpal8zkmxPg93eztG0DBB07WqgzoduxQtaxDXKtkCbCO7abd4IQ1AyqwqkQRNHTEfMpkPcLgvuB576JpqTJA1YNiVQw78g06HVcXsfTPt0XGyc=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 13:46:08 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%4]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 13:46:07 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, Jiang Liu
 <gerry@linux.alibaba.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "shuox.liu@linux.alibaba.com"
 <shuox.liu@linux.alibaba.com>
Subject: RE: [PATCH 1/6] amdgpu: add flags to track sysfs initialization status
Thread-Topic: [PATCH 1/6] amdgpu: add flags to track sysfs initialization
 status
Thread-Index: AQHbXNhmJI25iyeXPEiar5Bvrl+NA7MEHIuAgAD00VA=
Date: Fri, 3 Jan 2025 13:46:07 +0000
Message-ID: <BL1PR12MB589837ECB5AB98D7E281A1E485152@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <cover.1735795671.git.gerry@linux.alibaba.com>
 <737a46d7273d625ef8a1146925296bbdf57f2274.1735795671.git.gerry@linux.alibaba.com>
 <c1a4e8a6-2d6e-4e30-a6db-24c0a17b635d@amd.com>
In-Reply-To: <c1a4e8a6-2d6e-4e30-a6db-24c0a17b635d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6c433bec-05bc-4e87-8385-3a3c3126cb15;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-03T13:43:52Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DS7PR12MB5984:EE_
x-ms-office365-filtering-correlation-id: dd783dd2-79f7-4114-e0b0-08dd2bfcf9a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZTNwVmRzb25NeURDeU5EaWtsNUdwZnJaMW4xTFJlRlVZcEZ3dkRQelIzeFh0?=
 =?utf-8?B?bXV1MUNScjZ4NERhbjIwRm9vajFPamlyTThpQVJtaWlYaEhBWVhEV1JLTmxy?=
 =?utf-8?B?dStiQ0xURUwydzFpQ0pIYzJIU1I2SSszNXZqY3NnZkU4Y3lWV2RjQ1Z1b2NK?=
 =?utf-8?B?WUExLzRCY1lIQjl4N1lNWnlzN0FCb3IyR2Q5TDFoQmo3Nlh4bEZvVHlqT3p2?=
 =?utf-8?B?YzU5RStLZzFzM25iQ1RRZ3gzcktXOC9oODZPYytReFdPcW1FeFZtMTd2MUpW?=
 =?utf-8?B?T2tjL051UWtLNmcyRjVzUFcvSmUzRUZYeGtiaDlQWU1lRHhFVG1VUGdrdDY2?=
 =?utf-8?B?Q1ZvNWNydzRONS8vbFFjNGhNTkdpMm16cWFjcHlFdFlnNndFaDF5NzR3dXdp?=
 =?utf-8?B?OUFQMXJtT0JiVzFrVVUrWEVINDFUSm1BNnQ3c2ZHQVBNUGsxQ0xyMDlzMEtZ?=
 =?utf-8?B?VlZVL1Z3SjZXY3ZraHVLQVdBWkZLRURyTTdNQi9TYjI2clY0NVMrMVhVODli?=
 =?utf-8?B?MFNGR0dTNWhFMjhDWTdhRDAwTWFKMlR5RkJhMHFwaDNtMktaRmZCZm5OQVNz?=
 =?utf-8?B?cDBiTTNodXlSVmFrRmhLNlpLL3k0dlBzNGxuNEZ3UzFWaUlsWHpMUHdyVGly?=
 =?utf-8?B?bXNRcmxobDZubFJsR2dvZ2szQjZ1TEdZcXdIM0tnY25BaThZb1VtWE9wNGJj?=
 =?utf-8?B?bkJHTThuZkc1Q25QR1kzRFJjRWtyUzMwVUk2YVc4Q0dHMjM3WkNINTdVWXBJ?=
 =?utf-8?B?WWFuaXQ1VFRDbVBhVXFKT0RVSENhVDB3MGVTbE51Q2RrSWw3RUpjOUpsMFpB?=
 =?utf-8?B?dTJQSU5DNFZmenRQMXdlR2dOSzA5a2RkUjZ5UHh4aS9CM1hkZDhjTHlrSnlV?=
 =?utf-8?B?NHRlUEk1U3lxbXhyYVZNbTczVWFpeGVVOG5TREVIRGZmZ1FIcnFnc3ZGbjZv?=
 =?utf-8?B?dzVud2hkaFdHVUtpRmllVGdZVHZuL0duSjlSbTliYzZZSUlBVXhHOHhDOTFE?=
 =?utf-8?B?clNqckQyYVcvWEsyOFk4L1VDSVMvSlJaN1NlaG5pWnZwYnZpb1dLeC9jNWNW?=
 =?utf-8?B?dTkvVnp4MTNoZ3pmU3NRd2twVXRuNU9IVEFFSEkzYzV4eHJ0ZzJMU1VSV3Az?=
 =?utf-8?B?ZjNEK3VBLzVFaUdBZkxlSG5QN2VQQi9FU0YxWXhUTVErcjRSQU83bk5hOU1S?=
 =?utf-8?B?bFF3eW5LeDFZYlJmcG1WUzJkWWJaZENaZ3Q4RHhHS1ZkUkRkc1VySndPMWQ0?=
 =?utf-8?B?SVRVNzJxdlM3NlNqQmFndlQ3cFZvbUsycklFSmd5YkVpRUNRME1lQWpkRFht?=
 =?utf-8?B?SGlZTXRKdm1iaDNMR3FTbUkzTG5YaWNMeEFJaTFKTG5kODIxZjh1dkhsU0lh?=
 =?utf-8?B?ZzlWa01TNTBOWmw4c3pGU1dhQXBtbVlBUnlBWjlqNktweVkyQkJyV3VyUjcv?=
 =?utf-8?B?NCtVWU1BcDlhUkJ5Z2kxSHZ5OE1Xajk5Tzg2SklrMFVsR1d5UjFkZm9ZYTlu?=
 =?utf-8?B?a1dFcUF6WEdjWmtBektKUWF6ZFFjOGhZOGN6RG13Q1RIbGlmWGVTTlc5TzZw?=
 =?utf-8?B?WXlJeERQVVh1aE1KRlNsbDZicUcxbGdnYTF4aytlUzgrdG9vOGVwRmhWeHpp?=
 =?utf-8?B?S3NObDExQ2IraFZXblZ6OEhrNHZmemJHWm1hYThSd2crRzlMOEltMDJkYnNF?=
 =?utf-8?B?SHdjY0dKa3U1d3ZnQ3plMzNCcXZoK21GNlczNzdIczc4VFlwOGdtYjZNdHhh?=
 =?utf-8?B?UWpGM1FTSktsQjZacVp1L0pNSEkrNnE2WEFLU3kxaVNORyt4TUJkTEVCb0Vo?=
 =?utf-8?B?M2pSU0hvWUNuQ1lqekx1RGRNNS83eTNqcmhoS0h4cy9RTU5lZzY4TEVldFFn?=
 =?utf-8?B?czJtNlFCSXFkQzBBSW5WK1lsYmJFVnJSUDdqZnVZUEc3dUdtVTVmVG0vMHRJ?=
 =?utf-8?Q?yOTqp04jD45gOSPZHYmWVJ95vs6lXjrh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzZtY2xGcVdSMU9WTWYvK1B5dlVocnpDdkREUUJsNUs5SmRPeFUzWTB1TTF5?=
 =?utf-8?B?ZHJNUmwzUmJnVjVMa3F1SjdlUDYvQ096TG9TdkYxNERoYXh2MHdOTHdoNVJ6?=
 =?utf-8?B?VG9CVUdoZk5ESUR0b1Z2VFZjOC8wQ3FxMTBzUTQwcmI3Q0tObzlqblZBY0hP?=
 =?utf-8?B?OEV4aDJmamk4bXl4WEhOOUR1UTQyN0JWK1FWWjByaVV5SkFSN1llVHM1S3RL?=
 =?utf-8?B?RklVaVN0MjR6KzZRbUtEUVpjeTlIcGRhaHpaR1BvTDdhUzMyRUcwUStpTm9p?=
 =?utf-8?B?aUwzUjRFV2RPeXFwTCtQSG5GZmhEWEpIVnVITFNEaXcwbDF2UTh4eWNtK0pV?=
 =?utf-8?B?RWhkZ1I4WkxrYlE4cEF6eEZId0t4VVBNenJheEdac3VtSDliUkRhb3J2SnpT?=
 =?utf-8?B?VEZkN3kzRzNDR0h3TnBRTWxUeVM2SGhxb3R0SHFmV2tTbGh5R0NFbGFpNk9k?=
 =?utf-8?B?aFFYNW1JQm92Vi9LYnpwZjFqZm5OcHB0VWpmZG9wRVpnUW9iRHFvWk9mQ09q?=
 =?utf-8?B?aUxzR2RnaFA2MEZhWHlPYkI4R2ZpbVRFTmg2VS9lSWJ3cHdoaDdGNDV5WWZ5?=
 =?utf-8?B?YnZkUEtKakJpNU5nVE5lRy9MSnRjUzlKaFYzdUxqMmJETGx3YVE3TUQ5Z05Q?=
 =?utf-8?B?Qi9IclZGaTAxV3RiRWMrcElwQmF3dHliaG1SYnJvUWI3UlBDbE5NYXhHdnNn?=
 =?utf-8?B?NW5yd3o4WlV2NjdmVFR5enZIMTBycnlZU1FHQTNPUGYyZFFGdVBPaWZXK2sv?=
 =?utf-8?B?QjRxZHVnZ1d2RThtU01hb1o4RnJLTjg5R2J1VmtZWEVUaDJkaFZvKzhXb1Fn?=
 =?utf-8?B?RTZGZjRUR3FPQS9YM2dnTDc5VzQrQzExK0pyL28wdTg4Y0t1bkZUY0pUR2d3?=
 =?utf-8?B?RGl1U1o3K0JqYVpnczRoOGJCTm1JRDd6Z2NYWHhVOElGZFN4ZUpVQVpIaGpp?=
 =?utf-8?B?bTdCT2xJRHdIeE92NSsrcjhWTElGcXYya3BJc0dnM0hzYm9ETnd6VjNxM3Ba?=
 =?utf-8?B?OThWbjdCbm9Fc0Y4dDlVVjVsRnFUaCthT2NUVkVXdWhMdisxN1FDS3k0S1dp?=
 =?utf-8?B?bUdyZnBPa3JFRWZPOGdoU0ZWOWdscWx0alhrUVEvWlJZRkJFdFZrd3p4RnAv?=
 =?utf-8?B?WVZBUmM4OStDcktSOEI4NWZhZVVxQWs5cG5WZ0RiRGFkM2VDOWJ5cTdjZkRI?=
 =?utf-8?B?SUdPWG43eThYSzY0ZjhtbzRDY1NSZHF1WUtUNFFERlhGVVh3NWlkQUwzMlZh?=
 =?utf-8?B?cW9ORUtlZXJoT2lOQ0lsOCtGMkt1aE1rWlFDc1BPTmNSUFA1bXptRFFoUHR6?=
 =?utf-8?B?c0kzRVUvUm5yTmZyK283dDg3a1o3NFNjcEU4YUYwOFNMNkt5Ym8za3RDUHlX?=
 =?utf-8?B?TEhHa1cyRHVRdEhRdnpJTHB3SlN4Y0lHbWtZYXJoL1BNa1hpVnFqTWRuVzdj?=
 =?utf-8?B?TlQwRUphNUgraDJzRDludTd1ZkpZSEMvL1RVQVFOVzBNRmt4dkQ0MThXNVhM?=
 =?utf-8?B?d1VkVytKNFNiNFFNMVZjK3Z3MnZqQ04wNWVFNTYzS2p4VXJnV09EYmZ4V09u?=
 =?utf-8?B?ZlpjWkpzSTA2Qldkc1VtR3drV3k2TkF3TUhaSVU3dW1JTWRpZ05YeEo0cmJE?=
 =?utf-8?B?TlRFbU1VdmQxVzNWYXZvWHF3STJodk5PeHJuYmZzMkduVVZEakgwdCtTeFpG?=
 =?utf-8?B?YVNpUHFtKzRUa2dkUkRUdzBnWDlnc21OSnRkMWI5RWxoR2NLaWpycTRJSkcz?=
 =?utf-8?B?bUNuRVdQbEI5Rk95WVE4SXNlS212emllUVFjT0d1QW5BUzJ5Z29wNkFRTzNS?=
 =?utf-8?B?VjBMb3ZQUjE5dGxQQithc01WY2pBd0RXMk5qdGgrR0prMkZYREVaVmR3d1VX?=
 =?utf-8?B?ZDlUZ2dqbGZKTC9EdGFDVjc4R2N4VFprSng1U3Y4YzBLUXlrVEQvQmZsWWlw?=
 =?utf-8?B?NkJOWWI5NDV0U3F0RktiZVhPZVp4M3lRMUEwWHZWRFNXcUpUcXZZajJIZUxP?=
 =?utf-8?B?Q3V4aTJ5RTV6Mmp4SWd1NHZpMjNqY1cxOENQVndkamV2bUYyVXVRRWR3Z3VQ?=
 =?utf-8?B?K3AvQUw2SWcySG1XelZQd2RpekF6WnlJWFJMNnpTSWJaTVl5YkxLQVByV0s3?=
 =?utf-8?Q?rb2M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd783dd2-79f7-4114-e0b0-08dd2bfcf9a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2025 13:46:07.6701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWJgA0SMhXa810x/dbAdUPl9Fm8oCzAzj0nqVUo9N+3QS1+NGj3ZK9Zbd7Hd9N2czx+LMrRGUdOygekzR4KX4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGVuLCBYaWFvZ2FuZyA8
WGlhb2dhbmcuQ2hlbkBhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSAyLCAyMDI1
IDY6MDggUE0NCj4gVG86IEppYW5nIExpdSA8Z2VycnlAbGludXguYWxpYmFiYS5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgUnVzc2VsbCwNCj4gS2VudCA8S2VudC5SdXNzZWxs
QGFtZC5jb20+OyBzaHVveC5saXVAbGludXguYWxpYmFiYS5jb20NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCAxLzZdIGFtZGdwdTogYWRkIGZsYWdzIHRvIHRyYWNrIHN5c2ZzIGluaXRpYWxpemF0aW9u
IHN0YXR1cw0KPg0KPg0KPiBPbiAxLzEvMjAyNSAxMTozNiBQTSwgSmlhbmcgTGl1IHdyb3RlOg0K
PiA+IEFkZCBmbGFncyB0byB0cmFjayBzeXNmcyBpbml0aWFsaXphdGlvbiBzdGF0dXMsIHNvIHdl
IGNhbiBjb3JyZWN0bHkNCj4gPiBjbGVhbiB0aGVtIHVwIG9uIGVycm9yIHJlY292ZXIgcGF0aHMu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaWFuZyBMaXUgPGdlcnJ5QGxpbnV4LmFsaWJhYmEu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1Lmgg
ICAgICAgIHwgIDMgKysNCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYyB8IDM0ICsrKysrKysrKysrKysrKysrLS0tLS0NCj4gPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMzAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gaW5kZXggMjJjN2U5NjY5MTYyLi5lNGIxM2U3Mjk3
NzAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgN
Cj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiA+IEBAIC0x
MTU3LDYgKzExNTcsOSBAQCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSB7DQo+ID4gICAgIGJvb2wgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaW5fcnVucG07DQo+ID4gICAgIGJvb2wgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaGFzX3ByMzsNCj4gPg0KPiA+ICsgICBib29sICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN5c2ZzX2VuOw0KPiA+ICsgICBib29sICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGZydV9zeXNmc19lbjsNCj4gPiArICAgYm9vbCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByZWdfc3RhdGVfc3lzZnNfZW47DQo+ID4gICAgIGJvb2wgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdWNvZGVfc3lzZnNfZW47DQo+ID4NCj4gPiAgICAgc3RydWN0IGFtZGdwdV9m
cnVfaW5mbyAgICAgICAgICAqZnJ1X2luZm87DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+IGluZGV4IGQxYmI5ZTg1YjZkNy4uMzI0NDk2NmIw
YzM5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYw0KPiA+IEBAIC00NTMzLDggKzQ1MzMsMTMgQEAgaW50IGFtZGdwdV9kZXZpY2VfaW5pdChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgICAgICAgICBhZGV2LT51Y29kZV9z
eXNmc19lbiA9IHRydWU7DQo+ID4NCj4gPiAgICAgciA9IHN5c2ZzX2NyZWF0ZV9maWxlcygmYWRl
di0+ZGV2LT5rb2JqLCBhbWRncHVfZGV2X2F0dHJpYnV0ZXMpOw0KPiA+IC0gICBpZiAocikNCj4g
PiArICAgaWYgKHIpIHsNCj4gPiAgICAgICAgICAgICBkZXZfZXJyKGFkZXYtPmRldiwgIkNvdWxk
IG5vdCBjcmVhdGUgYW1kZ3B1IGRldmljZSBhdHRyXG4iKTsNCj4gPiArICAgICAgICAgICBhZGV2
LT5zeXNmc19lbiA9IGZhbHNlOw0KPiA+ICsgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgIGFk
ZXYtPnN5c2ZzX2VuID0gdHJ1ZTsNCj4gPiArICAgfQ0KPiA+ICsNCj4gbm90IG5lZWQgdXNlIHt9
DQoNClRoZSBrZXJuZWwgc3R5bGUgZ3VpZGUgc2F5cyB0aGF0IGlmIG9uZSBvZiB0aGUgaWYgYmxv
Y2tzIHJlcXVpcmVzIHt9LCB0aGF0IGFsbCBvdGhlciBibG9ja3MgcmVxdWlyZSBpdCB0b28sIGV2
ZW4gaWYgdGhlIGVsc2UgaXMgYSBzaW5nbGUgbGluZS4gSXQncyB0aGUgbGFzdCBibG9jayBiZWZv
cmUgMy4xIChTcGFjZXMpIGF0IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvdjQuMTAv
cHJvY2Vzcy9jb2Rpbmctc3R5bGUuaHRtbA0KDQpUaG91Z2ggd2l0aCBMaWpvJ3MgZmVlZGJhY2ss
IGl0IG1heSBnZXQgZHJvcHBlZCBhbHRvZ2V0aGVyIEluIHYyIGFueXdheXMuDQoNCiBLZW50DQoN
Cj4gPiAgICNpZmRlZiBIQVZFX1BDSV9EUklWRVJfREVWX0dST1VQUw0KPiA+ICAgICByID0gZGV2
bV9kZXZpY2VfYWRkX2dyb3VwKGFkZXYtPmRldiwgJmFtZGdwdV9ib2FyZF9hdHRyc19ncm91cCk7
DQo+ID4gICAgIGlmIChyKQ0KPiA+IEBAIC00NTQyLDggKzQ1NDcsMjEgQEAgaW50IGFtZGdwdV9k
ZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICJDb3VsZCBub3QgY3JlYXRlIGFtZGdwdSBib2FyZCBhdHRyaWJ1dGVzXG4iKTsNCj4g
PiAgICNlbmRpZg0KPiA+DQo+ID4gLSAgIGFtZGdwdV9mcnVfc3lzZnNfaW5pdChhZGV2KTsNCj4g
PiAtICAgYW1kZ3B1X3JlZ19zdGF0ZV9zeXNmc19pbml0KGFkZXYpOw0KPiA+ICsgICByID0gYW1k
Z3B1X2ZydV9zeXNmc19pbml0KGFkZXYpOw0KPiA+ICsgICBpZiAocikgew0KPiA+ICsgICAgICAg
ICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiQ291bGQgbm90IGNyZWF0ZSBhbWRncHUgZnJ1IGF0dHJc
biIpOw0KPiA+ICsgICAgICAgICAgIGFkZXYtPmZydV9zeXNmc19lbiA9IGZhbHNlOw0KPiA+ICsg
ICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgIGFkZXYtPmZydV9zeXNmc19lbiA9IHRydWU7DQo+
ID4gKyAgIH0NCj4gbm90IG5lZWQgdXNlIHt9DQo+ID4gKw0KPiA+ICsgICByID0gYW1kZ3B1X3Jl
Z19zdGF0ZV9zeXNmc19pbml0KGFkZXYpOw0KPiA+ICsgICBpZiAocikgew0KPiA+ICsgICAgICAg
ICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiQ291bGQgbm90IGNyZWF0ZSBhbWRncHUgcmVnIHN0YXRl
IGF0dHJcbiIpOw0KPiA+ICsgICAgICAgICAgIGFkZXYtPnJlZ19zdGF0ZV9zeXNmc19lbiA9IGZh
bHNlOw0KPiA+ICsgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgIGFkZXYtPnJlZ19zdGF0ZV9z
eXNmc19lbiA9IHRydWU7DQo+ID4gKyAgIH0NCj4gc2FtZSBhcyBhYm92ZQ0KPiA+DQo+ID4gICAg
IGlmIChJU19FTkFCTEVEKENPTkZJR19QRVJGX0VWRU5UUykpDQo+ID4gICAgICAgICAgICAgciA9
IGFtZGdwdV9wbXVfaW5pdChhZGV2KTsNCj4gPiBAQCAtNDY2NiwxMCArNDY4NCwxMiBAQCB2b2lk
IGFtZGdwdV9kZXZpY2VfZmluaV9odyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldikNCj4g
PiAgICAgICAgICAgICBhbWRncHVfcG1fc3lzZnNfZmluaShhZGV2KTsNCj4gPiAgICAgaWYgKGFk
ZXYtPnVjb2RlX3N5c2ZzX2VuKQ0KPiA+ICAgICAgICAgICAgIGFtZGdwdV91Y29kZV9zeXNmc19m
aW5pKGFkZXYpOw0KPiA+IC0gICBzeXNmc19yZW1vdmVfZmlsZXMoJmFkZXYtPmRldi0+a29iaiwg
YW1kZ3B1X2Rldl9hdHRyaWJ1dGVzKTsNCj4gPiAtICAgYW1kZ3B1X2ZydV9zeXNmc19maW5pKGFk
ZXYpOw0KPiA+IC0NCj4gPiAtICAgYW1kZ3B1X3JlZ19zdGF0ZV9zeXNmc19maW5pKGFkZXYpOw0K
PiA+ICsgICBpZiAoYWRldi0+c3lzZnNfZW4pDQo+ID4gKyAgICAgICAgICAgc3lzZnNfcmVtb3Zl
X2ZpbGVzKCZhZGV2LT5kZXYtPmtvYmosIGFtZGdwdV9kZXZfYXR0cmlidXRlcyk7DQo+ID4gKyAg
IGlmIChhZGV2LT5mcnVfc3lzZnNfZW4pDQo+ID4gKyAgICAgICAgICAgYW1kZ3B1X2ZydV9zeXNm
c19maW5pKGFkZXYpOw0KPiA+ICsgICBpZiAoYWRldi0+cmVnX3N0YXRlX3N5c2ZzX2VuKQ0KPiA+
ICsgICAgICAgICAgIGFtZGdwdV9yZWdfc3RhdGVfc3lzZnNfZmluaShhZGV2KTsNCj4NCj4gSWYg
Y3JlYXRpb25zIG9mIHRoZXNlIHN5cyBlbnRyaWVzIGZhaWwgZG9lcyBrZXJuZWwgc2VuZCB3YXJu
aW5ncyBvciBqdXN0DQo+IGlnbm9yZSB0aGF0IHdoZW4gZGVsZXRlIHRoZXNlIGVudHJpZXM/IFNl
ZW1zIGtlcm5lbCBrZWVwcyBzaWxlbmNlIGZvcg0KPiB0aGlzIGNhc2UuDQo+DQo+IFJlZ2FyZHMN
Cj4NCj4gWGlhb2dhbmcNCj4NCj4NCj4gPg0KPiA+ICAgICAvKiBkaXNhYmxlIHJhcyBmZWF0dXJl
IG11c3QgYmVmb3JlIGh3IGZpbmkgKi8NCj4gPiAgICAgYW1kZ3B1X3Jhc19wcmVfZmluaShhZGV2
KTsNCg==
