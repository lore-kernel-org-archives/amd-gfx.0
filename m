Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DE7CCD1AB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 03:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DF1B10E09A;
	Fri, 24 Oct 2025 03:50:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ITBIDjPq";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C407910E09A
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 03:50:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uo0+XUiwb6gL0aDd7WMaqZeHEMGch7dlZ+b36IxT3Nn24humM6ShBn0MNZxIQtTfqyB7ndBI9HnfrNOFTKGmg7I9Fz3+Qcxk+pkb6qLHxMA7kfYxoqg7OIPttz92Gofw+NfFRBdC97hG0W1Ix8a8iFCHvDAYfR7PAnBhxjw59CIsSzl2poTM5pSIi7CAL1NEr+/sWvVx5gTcpgLVM+MSOCgsdpSu5HLewpLuxjMdSfmEafRcN4PH6tcC4BHMnQY1/OLPVR7Atvt0Vou6GGDGoAGP3NNC+WVB8ba0EJv9ukUqUIK2gWPr9lL1gufUDGu1FZLBsgpBzvSerOO401r0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd/GDrTaki89rggUrie4dJM1YWcKWFCe7yKO/ITDZCk=;
 b=kDNr90KIHNnm+Gi6Avjr3R9tdCX6PvFN0md1NA8kHeKzN2RKA3Xf33ytclflE27nhTipGAOPqSTwWmNC7KijmYQnJ2WXZuyL3bp7tTKOJX9/7nzD42YvdulZYvQ2xAK9ntdCA0FN/E9cPj73O1NxjGlnzmUe4jtC+KWzTtwCPKgIJr8DRDC4b5xglJyVMlVMOF2kWJnmsmOh6+aaFrurcbeN+QsjryEoLRM1+d62mtMt/O12809OXeKWB+xwiRa67LF+wDc+J49JQT4oQeE+OqkNCbTt/xGR0L1gV19W43ehs+mFQ9UDfiP3SeXP9XH59ZAJyC9yvXL8xb3u8BtGIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd/GDrTaki89rggUrie4dJM1YWcKWFCe7yKO/ITDZCk=;
 b=ITBIDjPqRSitOe39Thv3SCbUXYWSYhy/FlO9G3o7oCQ8sXEtxOF3pSut9AJ6SguA9j7Gh2ANSE1e5SHYGRDCJcCOLPkSfmdaprDC3t7cuRVftsgJOa4ZuUIyEZ6q5lEGjnvjydlwJzxZr1nO44yX3xXGEMS+h4o6e0YegG9HBk8=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 03:50:39 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 03:50:39 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
 svm_range_validate_and_map()
Thread-Topic: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
 svm_range_validate_and_map()
Thread-Index: AQHcQ1+/G0JD4RpnQEK8GIUuJOKDRrTPzZiAgAB4FwCAAF2kkA==
Date: Fri, 24 Oct 2025 03:50:38 +0000
Message-ID: <IA0PR12MB820824CE6FA3648E5047CA2590F1A@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20251022142529.247778-1-srinivasan.shanmugam@amd.com>
 <20251023143443.277108-1-srinivasan.shanmugam@amd.com>
 <415952ac-b666-43d7-a8cc-c0081c8bc911@amd.com>
In-Reply-To: <415952ac-b666-43d7-a8cc-c0081c8bc911@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-24T03:20:05.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|DS0PR12MB8416:EE_
x-ms-office365-filtering-correlation-id: 0fa3f42f-0ad2-40ef-a8b9-08de12b07f34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?VTJqRXZiL3YxNmZWazlRSnFUTHRDOVF4NlNneFpxOVZHdE92bkZROU5pU0h0?=
 =?utf-8?B?aDVBRXBDVk4yTDYzMlFtYlBFS3hYTWVkTE9oYk1Ec0xhbGxWeFloQ0d3MkJv?=
 =?utf-8?B?eXFPL0lyekJyVGpyVUY3eFBDUUtwVWI2dUErYzBJTjZqb1hmd280S1lqWnRJ?=
 =?utf-8?B?bHdGd21lZmV5akExZ280dWxHUGx1R0I4aklLM0YrRkZJMHd0ckVsVzhTOWRz?=
 =?utf-8?B?Wjh4OWtpaXhpVkJjNkhiY0Z0ZXU0Z1JJRzdld2xPdHI4N2h3TjVYOU5XS2pC?=
 =?utf-8?B?QU1hdkpPZVpqNXFSYkxZMXI2b0ZwUy9RTGZQMFFPOUE5VnZ3cHVaL2pRZXE4?=
 =?utf-8?B?cEhNWCs3ZmUyQkEwMWYrMDFETGJ0d0VzWWZNSGpkRGU0RlEvUGExbC9DT1ls?=
 =?utf-8?B?SlpKb0FwZWF4K25oRk14N3Bnai93YTVKdHN4cHZKUUtueG5EZ3VBZjJDSkJa?=
 =?utf-8?B?dGdIU3EvSzRZL3pSOGxmWlVvYzNlZitjaUxjU3VPWDZxQ2VTL2lkbUNGWklm?=
 =?utf-8?B?em9hWXhtbVZsRnZJYXhobzFBZlVvVGRCVDZ6TVdEelFGekozMFlsVWFWNEZz?=
 =?utf-8?B?d1NYbmpTVlgxS25CL1RUUEsvYit6Z3g4eDN2UXlZYkxSVW55RmR3TkZ3MkY2?=
 =?utf-8?B?aUlpK0lGcjg3clMwOVN2YUMwY0Z6UU5tVTlyZ1kzb2pXUENqMTQyMVZIM1JK?=
 =?utf-8?B?K2xoK3NPQTYvMmxsVW51RHM1UlBocFdnUG00Nnc5bnlHN0ZFR1k2UngxQ1kr?=
 =?utf-8?B?ckJvdE9oRXdidDdZRFVKWjFzWkdweXFTUmU4TnBTc3pBWm5Qc3dYUlN3ZkFr?=
 =?utf-8?B?NjFVNWs3OXg4M0wzV01LNFI1NDExMzNjS0V2bG1PTkdvT2JTT2J4V3laQUJP?=
 =?utf-8?B?V3o3NmtUVVZQeW1UTUUzOWl0Snp1UTNnQnVTUHZuMmsrVkJVREI1bStEa1JK?=
 =?utf-8?B?S1R6TWJUclZIblREZG03TGRydTdxQXJ4OWV1bGdtS0pHNXlFVEh0TmJvYVlC?=
 =?utf-8?B?N0tRQTNyRFpQSC9LVUFSdk1vWVppbHZyTGZYVmZRdEo1MXZlSndKWlNldlBz?=
 =?utf-8?B?YkNDRFlaeWppcWY5ZEYyZ3RnWEZKTzlaWWJCZ3U1eWlwWmtzR1h1N2tTYlRU?=
 =?utf-8?B?VDAyYXZEQ2RPRUJmTk5uQTZTWmtmR2IrVHdqVUNJc2FXM2hiRm1CRWhMSUx1?=
 =?utf-8?B?bWh5bWNiRW1WRjFZV3JkNlNEMU16QmtMcjRrNmVWWEsvSFhJZy83OEtabEt3?=
 =?utf-8?B?cU9qU0ZrNU1sOURPRnZFWHpYWGNsWThQUmZvaUdFZEtnQlN5c3Z6ZWRJT3BQ?=
 =?utf-8?B?SXV1RS9qbEtuK2RxZVVDcjlxZ0t0Und2VXFLVnVUa2o4ZUh3RHRPeEJEL04x?=
 =?utf-8?B?YitURVB1dFZScHRMek1aR0lJWWl1d1dDL0ZYd0RWWmMxbkhXd3hUTk9abHNY?=
 =?utf-8?B?QkN0NWNlcEJxZWJoTVlTQjd4YXMxbXVqQ2hIQWhQbTl4dURYQkJUbkRMeExk?=
 =?utf-8?B?V0p3ZFNYOCtmMFNvWmpvUlVqVmNMbVd3NWRPUktMWVFOUnc3bTNkTG1iTkVY?=
 =?utf-8?B?cTU5aDRzK3ZrWCtFSllNNXVvVFpxeG9ITlZxNlRSaGlTbGdlWEVrQ21aamhv?=
 =?utf-8?B?RGs3MzRKK3liNTRIeXJWVHdzS05MdDNnaVdHMERQMjFGSTZFQjlkWk9HVmxU?=
 =?utf-8?B?ZjNsbzBMSjZyaHFzSWdTUGhyYmR1WlA0UDZtQ1RDTEx5ZUtkK3ZUM0ExSVVC?=
 =?utf-8?B?dUZETEJFa3Y0bGJYcHdvblBuRHpDNmZpWWFZeVJvQlhDR0xUeklDWFgrb2FE?=
 =?utf-8?B?M2p1MnVXSHZtSlYxSkVOa2l0cmZRS3pjWVFrdHVRRktMV2JKdlBKTUY0Q1Iz?=
 =?utf-8?B?L3IxcC9hcHZlZkpTb0ZqVk1PM2NMRVVxOUZZMUJwL1R6UEdLQTNnT1duTlpk?=
 =?utf-8?B?NHJNb3UxaFF6MWlNRi9JeDlZa2RVWnM5eUUxMjBWdmVrTElneXdjelFVZXgr?=
 =?utf-8?B?V2R5OFQ2V0N4WDNjNlJ1dU1GQ0c0SWdnZmRwYjNBbDdCYndYc1NuZ253NGhx?=
 =?utf-8?Q?nT7P3f?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anhLb1B3bFpIOXg2OTBqeXFMVmVGbWZ2M2ZHY1JUQi9FQUtrRFFVeDVmNU42?=
 =?utf-8?B?bU5xVmhUazlGVlJ2RWh2WC9PU1hySGFQVUErd1MrcTNXWTg3eEdacDZGWDBH?=
 =?utf-8?B?cm4rbDViMk5hUi8wKzBCNmc3UjhxS2ViMHU5dE56aUJYMmtBZWlmMnc4dkRG?=
 =?utf-8?B?WDZyOHVHMER1OHlnVXB3d2IvSS92bHh2aE84QUtFeUJlbXhsd0dadFJIZTUr?=
 =?utf-8?B?eldvanZqUExJWUVFcUtUS0NWeWRSQUNjRmlyTDlIRFBtTm5LeVNrZjNOZUdX?=
 =?utf-8?B?aGl2R0g4Q3JDT1NwT3RCK2VaZG5Xck4xRXo5ejEveTBQTzVPd0YzZjZrQ3lC?=
 =?utf-8?B?S2tYdTl4S3pnWnlzSTJtaTF2M3FBN0UzYUIwQnN4K1lQN2ZuMlRHSGsxSDBP?=
 =?utf-8?B?QjN0WnpGanVJZ2RGcUF2N3Nxb2tSMzFmRmp3ZS95UEtYTkM5MUlXbld0aUp2?=
 =?utf-8?B?ZjJnb0t0Q05CWWpncmNzeW9UZEJCU3RCa2p5dkZqakxrcExqQVJ3UVpXWldx?=
 =?utf-8?B?b0E2TEpnYVFKQXBRNkJyOXpHNVhSdHg3T0s3UzNVTW53QndYdjBONzkzVXlM?=
 =?utf-8?B?TjVVTWNVMXJPWVBQRVVnVlRtUU9qeURFL0RJdTVQRSt0WEI2YzlYenFxQ21s?=
 =?utf-8?B?OCtINGVla0xYSXdHWk1GSXZmNFJWM1ZVcDljNjVUUWNUTDl2QXRBMWJrS0lo?=
 =?utf-8?B?YzhPOUE5MCtvYy9RN0NOUEFrNXhIZm5nQ3U0WVJieUs4RXYwTXJKVmx5UGgz?=
 =?utf-8?B?c2VMNFZsNi9rM045ZWYwQnhaK3o2YkZrTEEvandGSG5SdFpKakxVNjBsa0ZC?=
 =?utf-8?B?YWRxZXVQR283OHVSTFVMTk45dVVLbm1WN21sUGxOOXlQa21BaWxVamxyWldE?=
 =?utf-8?B?SjN2UXp2RHltYVg2Q1NuemZFbkxFOTZlRC9ReTRqZm9XbXdiZXdrTE5BZHdn?=
 =?utf-8?B?cE11N3FqNVZmU1laNVkwa3VZZmhBMHBpQThRaXRxWUhadHBNVmkrdjNEdXZs?=
 =?utf-8?B?MDRmTDVsTWUxM0ZmTlNWVEdESHA4MlUxc1NkNzZWbGs1SFdzZHV4d216Wmor?=
 =?utf-8?B?d29ja2ZGQzNXUTRpTmM0aldPenp0T2NPOTNIQnB4Q3RDL1I0Rjk1ck9HY2Vs?=
 =?utf-8?B?aUttZ0pOcGlKZUlSSE02Mno3SmRUR0hmZVNSYW5tc0dqT0pSS1NQc3UrclNF?=
 =?utf-8?B?cU5Ua3NRMWt6TUo5WFlidzJlU21nVWJ2aCsyajdBYlZXQ3kzb2czRGVKZnJF?=
 =?utf-8?B?WEFsKzNJYzhHOXczdG9vNTQwSGo1OUdYU20xMU5ocXd3S25pNGdtM1hmbXlU?=
 =?utf-8?B?ZkdlcTdLdDVjaStKRVFzOVovUFRLQ2JhSlVYaWVzL2FsWExNYU9oRjZhWWRV?=
 =?utf-8?B?QVZPOER1aFZvM0xISk5QWDg4MVJOSGUyVGowdmFSNFphdE1wTU1GT1RUYkQz?=
 =?utf-8?B?Wi9IV0dReDFMUlV4Qzd6L2VHUkFiQmJnVklPNGJ0cEo4SFZLenJkcEtDdHNU?=
 =?utf-8?B?bFFXNFRZam1MbHYwTVJCTVpOM3pUT3lWOSt6UFBYek1vNzhPQWVrQ3ErUEVw?=
 =?utf-8?B?TmlxOVE4cUl0SFJFbXFFZTdQK2tWUkFxNWp2bW5XZkdSQllKV0FaSGJkc3B3?=
 =?utf-8?B?SHdrODlLSVE4SnViTHVBRGtlZ3FPNVc3bGp0SDVuMUkvRktJR0ZGR3ZuSmpX?=
 =?utf-8?B?VkdSTkM2a25lVHJCb01VSklPY1k3QVhIdTRnVXpJSWxYNGoyZlpCeVdVQlgz?=
 =?utf-8?B?OHBYdFRFSm5BUHRQWjIrQjdrOWVYZzRQRDgvSisycVp0eXBZYkZuZ29PL0dL?=
 =?utf-8?B?OWRDaWd2NXJlWExzK1VzSkhPOGltMnFmanN1NTNQc3J1U3NTdzJNSldwd3No?=
 =?utf-8?B?WHVsNEFmNTNDa2Rtc1NoQ1MzSER0alhnanBXblBBaC9xY2QxZ09YZHF0NzQr?=
 =?utf-8?B?eUt2SHlRVmx1aG4wR2IvWnRxdzV5OWRrQm44aTNBeG1lVUJ1aUVEdFF3YURu?=
 =?utf-8?B?bDYvSG9WSkI1M0tMajc4bUxPb2hUdU5vV0Rqbkc1L1pnOXNBVTVZUzY4VGZQ?=
 =?utf-8?B?K0s5MkU3RzFRU2pMNzlxcmJVWjhKT3hFdFBYWGYvT1BhbnNTZ0I1SStWQVc4?=
 =?utf-8?Q?a/Iw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa3f42f-0ad2-40ef-a8b9-08de12b07f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 03:50:39.0349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oz0rSEWjt5/jyNpZH3Oa8QZDWI35eoF4WkVKgl1HSP3tcggN+QMqsImoZRqDRRXLx5+IdwsPfxaGvocOKruNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGVuLCBY
aWFvZ2FuZyA8WGlhb2dhbmcuQ2hlbkBhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIg
MjQsIDIwMjUgMzoxNSBBTQ0KPiBUbzogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FO
LlNIQU5NVUdBTUBhbWQuY29tPjsNCj4gS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBZYW5nLCBQaGlsaXAg
PFBoaWxpcC5ZYW5nQGFtZC5jb20+OyBLaGF0cmksDQo+IFN1bmlsIDxTdW5pbC5LaGF0cmlAYW1k
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2M10gZHJtL2FtZGtmZDogRml4IHVzZS1hZnRl
ci1mcmVlIG9mIEhNTSByYW5nZSBpbg0KPiBzdm1fcmFuZ2VfdmFsaWRhdGVfYW5kX21hcCgpDQo+
DQo+DQo+IE9uIDEwLzIzLzIwMjUgOTozNCBBTSwgU3Jpbml2YXNhbiBTaGFubXVnYW0gd3JvdGU6
DQo+ID4gVGhlIGZ1bmN0aW9uIHN2bV9yYW5nZV92YWxpZGF0ZV9hbmRfbWFwKCkgd2FzIGZyZWVp
bmcgYHJhbmdlYCB3aGVuDQo+ID4gYW1kZ3B1X2htbV9yYW5nZV9nZXRfcGFnZXMoKSBmYWlsZWQu
IEJ1dCBsYXRlciwgdGhlIGNvZGUgc3RpbGwgdXNlZA0KPiA+IHRoZSBzYW1lIGByYW5nZWAgcG9p
bnRlciBhbmQgZnJlZWQgaXQgYWdhaW4uIFRoaXMgY291bGQgY2F1c2UgYQ0KPiA+IHVzZS1hZnRl
ci1mcmVlIGFuZCBkb3VibGUtZnJlZSBpc3N1ZS4NCj4gPg0KPiA+IFRoZSBmaXggc2V0cyBgcmFu
Z2UgPSBOVUxMYCByaWdodCBhZnRlciBpdCBpcyBmcmVlZCBhbmQgY2hlY2tzIGZvcg0KPiA+IGBy
YW5nZWAgYmVmb3JlIHVzaW5nIG9yIGZyZWVpbmcgaXQgYWdhaW4uDQo+ID4NCj4gPiB2MjogUmVt
b3ZlZCBkdXBsaWNhdGUgIXIgY2hlY2sgaW4gdGhlIGNvbmRpdGlvbiBmb3IgY2xhcml0eS4NCj4g
Pg0KPiA+IHYzOiBJbiBhbWRncHVfaG1tX3JhbmdlX2dldF9wYWdlcygpLCB3aGVuIGhtbV9yYW5n
ZV9mYXVsdCgpIGZhaWxzLCB3ZQ0KPiA+IGt2ZnJlZShwZm5zKSBidXQgbGVhdmUgdGhlIHBvaW50
ZXIgaW4gaG1tX3JhbmdlLT5obW1fcGZucyBzdGlsbA0KPiA+IHBvaW50aW5nIHRvIGZyZWVkIG1l
bW9yeS4gVGhlIGNhbGxlciAob3IgYW1kZ3B1X2htbV9yYW5nZV9mcmVlKHJhbmdlKSkNCj4gPiBt
YXkgdHJ5IHRvIGZyZWUgcmFuZ2UtPmhtbV9yYW5nZS5obW1fcGZucyBhZ2FpbiwgY2F1c2luZyBh
IGRvdWJsZQ0KPiA+IGZyZWUsIFNldHRpbmcgaG1tX3JhbmdlLT5obW1fcGZucyA9IE5VTEwgaW1t
ZWRpYXRlbHkgYWZ0ZXINCj4gPiBrdmZyZWUocGZucykgcHJldmVudHMgYm90aCBkb3VibGUgZnJl
ZS4gKFBoaWxpcCkNCj4gd2hhdCB5b3UgZml4IGlzIG5vdCAidXNlLWFmdGVyLWZyZWUiLCBpdCBp
cyBwcmV2ZW50aW5nIGRvdWJsZSBmcmVlLCByaWdodD8NCj4gPiBJbiBzdm1fcmFuZ2VfdmFsaWRh
dGVfYW5kX21hcCgpLCBXaGVuIHIgPT0gMCwgaXQgbWVhbnMgc3VjY2VzcyDihpIgcmFuZ2UNCj4g
PiBpcyBub3QgTlVMTC4gIFdoZW4gciAhPSAwLCBpdCBtZWFucyBmYWlsdXJlIOKGkiBhbHJlYWR5
IG1hZGUgcmFuZ2UgPSBOVUxMLg0KPiA+IFNvIGNoZWNraW5nIGJvdGggKCFyICYmIHJhbmdlKSBp
cyB1bm5lY2Vzc2FyeSBiZWNhdXNlIHRoZSBtb21lbnQgciA9PQ0KPiA+IDAsIHdlIGF1dG9tYXRp
Y2FsbHkga25vdyByYW5nZSBleGlzdHMgYW5kIGlzIHNhZmUgdG8gdXNlLiAoUGhpbGlwKQ0KPiA+
DQo+ID4gRml4ZXM6IGM1ZTM1N2M5MjRlNSAoImRybS9hbWRncHU6IHVwZGF0ZSB0aGUgZnVuY3Rp
b25zIHRvIHVzZSBhbWRncHUNCj4gPiB2ZXJzaW9uIG9mIGhtbSIpIFJlcG9ydGVkIGJ5OiBEYW4g
Q2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQo+ID4gQ2M6IFBoaWxpcCBZYW5n
IDxQaGlsaXAuWWFuZ0BhbWQuY29tPg0KPiA+IENjOiBTdW5pbCBLaGF0cmkgPHN1bmlsLmtoYXRy
aUBhbWQuY29tPg0KPiA+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+DQo+ID4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFu
bXVnYW1AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9obW0uYyB8IDEgKw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3N2bS5jICAgIHwgNiArKysrLS0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9obW0uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2htbS5jDQo+ID4gaW5kZXggZDZmOTAzYTJkNTczLi45MGQyNmQ4MjBiYWMgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2htbS5jDQo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2htbS5jDQo+ID4gQEAg
LTIyMSw2ICsyMjEsNyBAQCBpbnQgYW1kZ3B1X2htbV9yYW5nZV9nZXRfcGFnZXMoc3RydWN0DQo+
ID4gbW11X2ludGVydmFsX25vdGlmaWVyICpub3RpZmllciwNCj4gPg0KPiA+ICAgb3V0X2ZyZWVf
cGZuczoNCj4gPiAgICAga3ZmcmVlKHBmbnMpOw0KPiA+ICsgICBobW1fcmFuZ2UtPmhtbV9wZm5z
ID0gTlVMTDsNCj4gPiAgIG91dF9mcmVlX3JhbmdlOg0KPiA+ICAgICBpZiAociA9PSAtRUJVU1kp
DQo+ID4gICAgICAgICAgICAgciA9IC1FQUdBSU47DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3N2bS5jDQo+ID4gaW5kZXggZjA0MTY0MzMwOGNhLi4xMDNhY2I5MjVjMmIgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jDQo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jDQo+ID4gQEAgLTE3NDQs
NiArMTc0NCw3IEBAIHN0YXRpYyBpbnQgc3ZtX3JhbmdlX3ZhbGlkYXRlX2FuZF9tYXAoc3RydWN0
DQo+IG1tX3N0cnVjdCAqbW0sDQo+ID4gICAgICAgICAgICAgICAgICAgICBXUklURV9PTkNFKHAt
PnN2bXMuZmF1bHRpbmdfdGFzaywgTlVMTCk7DQo+ID4gICAgICAgICAgICAgICAgICAgICBpZiAo
cikgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfaG1tX3JhbmdlX2Zy
ZWUocmFuZ2UpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICByYW5nZSA9IE5VTEw7
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByX2RlYnVnKCJmYWlsZWQgJWQgdG8g
Z2V0IHN2bSByYW5nZSBwYWdlc1xuIiwgcik7DQo+ID4gICAgICAgICAgICAgICAgICAgICB9DQo+
ID4gICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiBAQCAtMTc2MSw3ICsxNzYyLDcgQEAgc3RhdGlj
IGludCBzdm1fcmFuZ2VfdmFsaWRhdGVfYW5kX21hcChzdHJ1Y3QNCj4gbW1fc3RydWN0ICptbSwN
Cj4gPiAgICAgICAgICAgICBzdm1fcmFuZ2VfbG9jayhwcmFuZ2UpOw0KPiA+DQo+ID4gICAgICAg
ICAgICAgLyogRnJlZSBiYWNraW5nIG1lbW9yeSBvZiBobW1fcmFuZ2UgaWYgaXQgd2FzIGluaXRp
YWxpemVkDQo+ID4gLSAgICAgICAgICAgICogT3ZlcnJyaWRlIHJldHVybiB2YWx1ZSB0byBUUlkg
QUdBSU4gb25seSBpZiBwcmlvciByZXR1cm5zDQo+ID4gKyAgICAgICAgICAgICogT3ZlcnJpZGUg
cmV0dXJuIHZhbHVlIHRvIFRSWSBBR0FJTiBvbmx5IGlmIHByaW9yIHJldHVybnMNCj4gPiAgICAg
ICAgICAgICAgKiB3ZXJlIHN1Y2Nlc3NmdWwNCj4gPiAgICAgICAgICAgICAgKi8NCj4gPiAgICAg
ICAgICAgICBpZiAocmFuZ2UgJiYgIWFtZGdwdV9obW1fcmFuZ2VfdmFsaWQocmFuZ2UpICYmICFy
KSB7IEBAIC0xNzY5LDcNCj4gPiArMTc3MCw4IEBAIHN0YXRpYyBpbnQgc3ZtX3JhbmdlX3ZhbGlk
YXRlX2FuZF9tYXAoc3RydWN0IG1tX3N0cnVjdCAqbW0sDQo+ID4gICAgICAgICAgICAgICAgICAg
ICByID0gLUVBR0FJTjsNCj4gPiAgICAgICAgICAgICB9DQo+ID4gICAgICAgICAgICAgLyogRnJl
ZSB0aGUgaG1tIHJhbmdlICovDQo+ID4gLSAgICAgICAgICAgYW1kZ3B1X2htbV9yYW5nZV9mcmVl
KHJhbmdlKTsNCj4gPiArICAgICAgICAgICBpZiAocmFuZ2UpDQo+DQo+IENhbiBqdXN0IGNoZWNr
IGlmKCFyKSBoZXJlIGFuZCByZW1vdmUgInJhbmdlPU5VTEwiIGFib3ZlPyBpZiByIGlzIG5vdCAw
IHJhbmdlIGhhcw0KPiBiZWVuIGZyZWVkLCBpZiByIGlzIDAgZnJlZSByYW5nZSBoZXJlLg0KDQoN
CkJ1dCB0aGVyZSBhcmUgbGF0ZXIgc3BvdHMgd2hlcmUgciBiZWNvbWVzIG5vbi16ZXJvIGFmdGVy
IGdldF9wYWdlcygpIHN1Y2NlZWRlZCBhbmQgcmFuZ2UgaXMgdmFsaWQ6DQpzdm1fcmFuZ2VfZG1h
X21hcCguLi4pIGNhbiBmYWlsIOKGkiBzZXRzIHIgIT0gMC4NCiFhbWRncHVfaG1tX3JhbmdlX3Zh
bGlkKHJhbmdlKSDihpIgeW91IHNldCByID0gLUVBR0FJTi4NCiFsaXN0X2VtcHR5KCZwcmFuZ2Ut
PmNoaWxkX2xpc3QpIOKGkiB5b3Ugc2V0IHIgPSAtRUFHQUlOLg0KSW4gYWxsIHRocmVlIGNhc2Vz
LCB5b3VyIG5ldyB0YWlsIGxvZ2ljIGlmICghcikgYW1kZ3B1X2htbV9yYW5nZV9mcmVlKHJhbmdl
KTsgc2tpcHMgZnJlZWluZyBiZWNhdXNlIHIgIT0gMCBub3cuIFNpbmNlIHlvdSBhbHNvIHJlbW92
ZWQgcmFuZ2UgPSBOVUxMOyBhZnRlciB0aGUgZWFybHkgZnJlZSwgbm90aGluZyBlbHNlIGZyZWVz
IGl0IOKGkiBtZW1vcnkgbGVhay4NCg0KUmVnYXJkcywNClNyaW5pDQoNCj4NCj4gUmVnYXJkcw0K
Pg0KPiBYaWFvZ2FuZw0KPg0KPiA+ICsgICAgICAgICAgICAgICAgICAgYW1kZ3B1X2htbV9yYW5n
ZV9mcmVlKHJhbmdlKTsNCj4gPg0KPiA+DQo+ID4gICAgICAgICAgICAgaWYgKCFyICYmICFsaXN0
X2VtcHR5KCZwcmFuZ2UtPmNoaWxkX2xpc3QpKSB7DQo=
