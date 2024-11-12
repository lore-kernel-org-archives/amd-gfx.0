Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7B6D41D44
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 01:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9BFE10E1D5;
	Tue, 12 Nov 2024 01:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y4GeNSKl";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCBD210E1D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 01:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lm60jiRNFcgqRChJZaZHr1mcmLsCnEjksS8CFD4gtS1azR8aya/lrS+EYSVejseqiLyGj+wcFRvI81GLVhrgcv2YqeAQS+kPqB4lGgNFW4HYREa/04Rr6KV6blD4BQfyBpn41FwJx7TsEHSQez+lqIPJwQNVLrR4xoarWMH3j0ubBSOPo72q80Eb2gc+g5wmBSRsL42WOBk2kmS+XYYURPsaZhbjx4KhKnYln4+6XMLRSwKnMv5TGyl2a+g5GrT8mpn+0TJj+bzXYtIsiA7ABC4hWExbWylI6mxrl+ebFWZlcF2LzeLV8iDNVXj29euVW1/ENUtT9tyopSaHXSqTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y25QwzxJcPpJlT47Xnxu1cs+dcVGSDV8ROCzPmpHDFM=;
 b=TuFQ5IjYcaXKZEfYxnBY5RALOvJnKdpLhz+t71yEZUdeA4d9CLMdJyNTHSMfRMeedcyeVXNhyL5nrp8Yh3bRjhio83Ln4PiEFXuONHmZiB9mbHbZIntcXoveV9OsaYYNHy21RRukHnCUzh0jGCMw8xOz3jZVYrgLxMl4EMTl5ZtoOR6mTx9wAJmiHJkzDaBY6MoYfAMEToW+UBr3kUCnSo5ooBpTsD8IvheeLHlzPhpE05czZ2igiMZkuWOVDYLwjfNim4vQ4CwesLtaTHsPGCBlBSJ+UoVtUvD4xX7nEmAT5RAUslpeSlpWbioKLs2F47Sqk889aeGxNCI7ivGWVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y25QwzxJcPpJlT47Xnxu1cs+dcVGSDV8ROCzPmpHDFM=;
 b=y4GeNSKlY6zbjVDaRDUaTwizrDz4OxkNYl1jvf6xMvkOLXaX39GA3yi5KxuNyfJth2vXfxDwPufSxXlEyJFt6V7rn1qox9PEMOa8iXfVq55/EgrWq3hm6Q0Q8KmVHB2VI5npmn1Vs53jmEWqhu8IOxf3K3L3CL2rYdox1o/TDj8=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.26; Tue, 12 Nov 2024 01:09:45 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 01:09:44 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Liu, Leo" <Leo.Liu@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add amdgpu_vcn_sched_mask debugfs
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add amdgpu_vcn_sched_mask debugfs
Thread-Index: AQHbNFi32IgQLzTYgku5bqJJ8VqU+7Ky1icw
Date: Tue, 12 Nov 2024 01:09:44 +0000
Message-ID: <DM4PR12MB5152985B367A81E785CECDB4E3592@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20241111164126.2195380-1-sathishkumar.sundararaju@amd.com>
 <20241111164126.2195380-2-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20241111164126.2195380-2-sathishkumar.sundararaju@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1af0a233-f37b-480b-bcab-704c91f179d6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-12T01:08:45Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS7PR12MB6285:EE_
x-ms-office365-filtering-correlation-id: 0367a983-6d5b-4c82-0b03-08dd02b6b1cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RlMrd21hcmNNVXhjNUR2Z09hbm5pNTNsTmsxeDF5a3kyUENZbDMxdHlJSStS?=
 =?utf-8?B?ZllPQWtNcmNaSUluakNTLzhVUWZFbGxjTlVFN2NubVlZRTZQRWhYU0ZCRWNZ?=
 =?utf-8?B?Q0l4eGZKNk9PMjlway9DOXRhczNoc1NEOVpTQW1zeHNYL0JreGk1TDhoS29z?=
 =?utf-8?B?K1AwN3hENzR2bkhCZlMvRG85aEFnV3ZqeUphRE9hVzJGNDdhUXlKYktTWWFk?=
 =?utf-8?B?UjdLY0dTUHFPUEJvTFUvQ0ZqUW4wMjdtcHFMTThlWHZ0ZVZWWFV3cEFycCtM?=
 =?utf-8?B?MWo1Ymlqazk0YjRMNytmcllsN29pVjVTbHRRRjRNMFBZZ21OejlwbUx2SXRV?=
 =?utf-8?B?RnNCbThBTit2azAzVkhpSWtTbFVsdzlLYVhGbXlvRDRuSWUzQ3RLbjk3bk5I?=
 =?utf-8?B?K1MwVE9sWkwrVzBvQzgybkpRVHIrY1lzdWNSbjVORUliUWhkTHY2dEZiRVA0?=
 =?utf-8?B?b0JmdjFubVBTeFpHSGRYdmhnWlF6eCtJYUVjVnFLNm96L0JHYjVDQXhiRFFR?=
 =?utf-8?B?ZWdpTVpsQUNXbU53bkFzQ0FLSG9lQnM4YlJENFAxYllLeG5jSkt1M1l0TXA4?=
 =?utf-8?B?MDVjcUllaDBjeEsrZDdib0FGM2RSUm5WY3cvK0s5a24rTHRaam41RDRkTm85?=
 =?utf-8?B?S1VUbnhiWUJnUTJsK0pxazRIdFFQS3h6UXFuem9jaFhZSW5jWnNaalJSYjBz?=
 =?utf-8?B?c0RFc25QTWFYMGRaN2RxbkVVdlgvU0dEU2NHMlQweWJUZmQ4R0g2WWpCdnE0?=
 =?utf-8?B?WlFVRi80RkdHWDFiN1ZnL2RUYkY2VmdocUtLVUk3Y1lIK3NvdEhXNTc3OVBQ?=
 =?utf-8?B?R29OUnRFODdtWXgzK3dGaTFKQmVhdVBLcTNWdUxFaGRmU3lVcjA2c2VSQmtz?=
 =?utf-8?B?aWVvOG1mSXZ0L2FiYkJxbytLNmpJSU14UWR5ZHNwZzRxR1N6MW5mRERPeEw4?=
 =?utf-8?B?SnpmOE5JWVByT25rUkYreWRpeWRzenpqTUwyWGxHUGc3NGcvbkZxZ0Mvck93?=
 =?utf-8?B?a0hqd1oxbTZhVVhxb1dQZGZtb24yM3JQTlBBQzZUMmJiYVZHZXZRM3V2OWhl?=
 =?utf-8?B?TDRpNml5YTAxdWJIRURCYVRkcXBDdjZaR01EcjdXTDVlV2VTV3pEUzVtdTdj?=
 =?utf-8?B?WjQ0YTNZaWE1N2sxRVpHd2d5a1RFV0ZsMHJBVGJuL2gwaDh1S01ZZURoOE1r?=
 =?utf-8?B?SzdCVU5yQlZVZ1kxcjVPWk51VHQvVkZudlN5eG9YbHp0VXpwZDA5ejdwc2ht?=
 =?utf-8?B?aU9XQzloaHBLV0kzMHY1TjFWV29Nd2dpcUw5NG9kem5CZFU0bUpzNWRKR052?=
 =?utf-8?B?Wndyc0ZsQUpIMnU5T0lXVUtVQ08vMFZtQjZ6OU5waHJBb1BJbmowSWhMdTF1?=
 =?utf-8?B?SjVuMVIwUmJMekdRTVJUQ3BDamU5VkJ1MDJaUWZWalppbUtHNzdrL3pyZ3NZ?=
 =?utf-8?B?Nmo4YmlUS2NVSW5GdmVrM3ZHaTkydUNtdEpTVHFZVk4rRVMvWE9OUW1RQm9K?=
 =?utf-8?B?ZnAxb29VU0ZLbXRjS2JQeWVYb1N3bjFPYWhlVlB2V0lpeEZkZXZvVjYxcXo3?=
 =?utf-8?B?aHZIYm1DY3dhV1paT1I3WGx2K2VtMUt1eFdWSGp0dVYzQ0ZGNEpHWXo3SGtY?=
 =?utf-8?B?ckdORG1pOHh0QzRhZ2ZRdG1mbFNOMXZXbjlMZ3VwYTBoYkxWeUY3THd5SUJV?=
 =?utf-8?B?M2FSOHI4L1lnRjc0alJaem1pRGxhaTgvTXR1MUhBa016YVB3akloVTJyaEs3?=
 =?utf-8?B?Rk44L09qeS9jdUhiSU0yU0xndEp6Z2lkSmRIMXdYU0U0bTc3QzcyRHVLRWNI?=
 =?utf-8?Q?azYnBM+IUgoaouYO3vZdQ7IqS9YnMhpi371nQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGNHVWdGUWE3WWd2cjU4ZkxFY0NNTE9uQW9XM3N4M1pHZVRNdWo1aVdrbGtT?=
 =?utf-8?B?R004YjFUZnNEcGF4bEtwVitJSVNYYk5lMG4zSThWeHBCWmhYYy9QVDRIWDYr?=
 =?utf-8?B?V3hFdlh0WnhUNEdkTFBHeENTVUVCZkRNV05FSFRlMS9sTi9vR0ZVcDR0dVBy?=
 =?utf-8?B?TDlKanlTZFpVSlY2TW9iV2lxbHhISkxRazlQOGZibUJXTjJWYVZCK3liUFVF?=
 =?utf-8?B?Wk14R2JnYmc4TFl5Vyt1Y3B2TGplMUJselFpYUxuV2lNWW9wRUZiVjVva3B6?=
 =?utf-8?B?Q1hmc0V5R1VnWTZOL1hlUGxMbHNzT2dwOHcwZUZZbUlxL1FhYUIvcEs3NDFE?=
 =?utf-8?B?R2I0dXI5QnAyMDB0S0ZzNG5FWEJvSmpJMmFla0dlUVh2clZkeVdCRzVyQ0ZM?=
 =?utf-8?B?M0dRS0dtT1RZYUZIaUlRZWpVQmtYbDd6d1BIRCtVY3VqckFCcTI0U2pMdlhp?=
 =?utf-8?B?WE16YjVQNDMwWlVVSFduMjNSdnU0eGZrL1lVUFdtY2ZDdFRORzQzeUREMDR0?=
 =?utf-8?B?WTBMdzU3c0dKUXN0ZkJUNzd6T3RVbWNCR0VqeFNNa29HWFpGcDhPekVXckNC?=
 =?utf-8?B?OVdMTGFkUlJtZmZmQ2VGeWw5dE1sNzlXOVR5UVFSV04vZ3JGZVRKUzIxSkpk?=
 =?utf-8?B?TTlyUlBvRXp3RklBNHNBNDJRNnMrUFcySlFtRXoxcmpSU3dYV1ZqUTdyR3VU?=
 =?utf-8?B?amdrYis5Q0JTTDllN29ndmFpQ0JNS1ErSExpb2gyYVVZWnJxck1nUTBSMFBz?=
 =?utf-8?B?dTNSeEJZUTd4cmJrL1VIS2dPTHJ2Slp2OTcycmxldHZFKzlYVyszWEF3Qm5E?=
 =?utf-8?B?WEZDWFR1dlRQdDBuSTU5L3ZKWnc0TkUyUU13c2hGR3MzLzJnRHEzTCtZR1Z4?=
 =?utf-8?B?NmpHVjhDNnVBTHlYSE5IdUxHRk9iVWFCSSt0bXoyOGxqT2psbTdOM0RQOFhR?=
 =?utf-8?B?Q3k3OEIyU1JpUGRIUFM3ZGtkSDVzZkxicTVCTWh1OFhDS1h3UXJ1bWI4R3dD?=
 =?utf-8?B?c281MVNxK1c3MnNadmovTGFMNjJTZWlZM0JkSmovdTVGS0dmRGsvTUhaR29m?=
 =?utf-8?B?Q0Q4YzdPdUVsQjBwTlFSdHFQNjdEQitqRVhRUnJ5bDlkajE2ZG5tVUpTRjFI?=
 =?utf-8?B?OGFnK25YRDZVRm5nMnJlU3VvNWhadlUzSUpod3BJT05JZSs4VVljdXpLTkgr?=
 =?utf-8?B?dnRLWUJ0ZzJucnBnSExyME9KMDV0cXBQZE1JYy8wL2lsMUkzTEtnUHNJdGdk?=
 =?utf-8?B?c1k0TUpKbEEvMkNLS2FYTkdrTk9Ja1ZteU1jMVRRL1FJSmdRWlA3WFNjUTRu?=
 =?utf-8?B?VloxS2JNQkNmdUNVRzh3ZkszK2Nrdlk1anlMTzZBalRlTHRMMVFWVEx5bE1w?=
 =?utf-8?B?VFNwdHVwMm1HRUNSOTRMK09WR2FPSk9YYUJSZHVUVW82NFZZcktLQWpSRkF4?=
 =?utf-8?B?Rlh3UzMwUHdOUHNia2xBbnlKVWRRTUNJMEVTVHZOU3VhMnpaMFdiSU1vNWht?=
 =?utf-8?B?WGdrRWlZVUlGU1lrVklUbzVBbmhMcHp4WERtaVFPVnFzTEpBWXpJZTJuK2h6?=
 =?utf-8?B?cmRsTXNIMFAwZ3ArWnkwQXQ5YkswNTJ4QWRRNk9mcFJPME5RMXZVajFpZnhP?=
 =?utf-8?B?cUIzbkpRV2RCM0I5VUFLdFUxK2sremo3cXEyaE8yUVFxemh1dzdYS2VxQWJy?=
 =?utf-8?B?K1h4WjU4L1pxM1U4dzliVmlPeGFGNDdXRHFQaEsxOUJjUFdieWZReGVBMmx2?=
 =?utf-8?B?Q3lLS0NxVVAyTHNtWDlDQ2NvWE8wbDlSb0VaYVR1Qk43Rk5OVXNMMWYrU3NQ?=
 =?utf-8?B?Y1hpUkFWU2xGMnpLcFNwQ0U4dFo1QjJWVDYxNU5GVnVNb2JSV0JlRlE5bVJj?=
 =?utf-8?B?VmZ3dEorNEVEdnlrOG83UVdZYWxvMmhsdVBPTnZwQlR5NWtWMU0wcG5mMk5N?=
 =?utf-8?B?UHdmdlRrUWxSSnZlMTZoZ25RdFdqWEE4azZ2a0E2cklHOTBOdWtqU25qaGRr?=
 =?utf-8?B?bjdBUjdxVXdkMnpNWXFDaEpqVzdadTd0QTErTDVsK2s4d3BkcU85Z0dOaEI0?=
 =?utf-8?B?UHg5MDFQam1wY3Z5ajJ3cnlCRUVJZkZuTG9DUjgvcmVBektLeHBONzJTTlBM?=
 =?utf-8?Q?uvzg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0367a983-6d5b-4c82-0b03-08dd02b6b1cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 01:09:44.6633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FZ3xiM3JRJYPZllBzaJHB8xN0WsWDF+OZVJrT4Ood8u6oxqQHWPv27z+p8WEZXOlbvpYSNH0UL+3FRXEwKCkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285
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
Cg0KVGhpcyBwYXRjaCBsb29rIGdvb2QgZm9yIG1lLA0KUmV2aWV3ZWQtYnk6IEplc3NlIFpoYW5n
IDxqZXNzZS56aGFuZ0BhbWQuY29tPg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVo
YWxmIE9mIFNhdGhpc2hrdW1hciBTDQpTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxMiwgMjAyNCAx
Mjo0MSBBTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogTGl1LCBMZW8g
PExlby5MaXVAYW1kLmNvbT47IFN1bmRhcmFyYWp1LCBTYXRoaXNoa3VtYXIgPFNhdGhpc2hrdW1h
ci5TdW5kYXJhcmFqdUBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIIDIvMl0gZHJtL2FtZGdwdTog
QWRkIGFtZGdwdV92Y25fc2NoZWRfbWFzayBkZWJ1Z2ZzDQoNCkFkZCBkZWJ1Z2ZzIGVudHJ5IHRv
IGVuYWJsZSBvciBkaXNhYmxlIGpvYiBzdWJtaXNzaW9uIHRvIHNwZWNpZmljIHZjbiBpbnN0YW5j
ZXMuIFRoZSBlbnRyeSBpcyBjcmVhdGVkIG9ubHkgd2hlbiB0aGVyZSBpcyBtb3JlIHRoYW4gYW4g
aW5zdGFuY2UgYW5kIGlzIHVuaWZpZWQgcXVldWUgdHlwZS4NCg0KU2lnbmVkLW9mZi1ieTogU2F0
aGlzaGt1bWFyIFMgPHNhdGhpc2hrdW1hci5zdW5kYXJhcmFqdUBhbWQuY29tPg0KLS0tDQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyB8ICAxICsNCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgICAgIHwgNjggKysrKysrKysrKysrKysr
KysrKysrDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oICAgICB8ICAx
ICsNCiAzIGZpbGVzIGNoYW5nZWQsIDcwIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQppbmRleCBhNjgzMzhjYjdiNGEuLjQ5Y2E4
YzgxNDQ1NSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZWJ1Z2ZzLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2Zz
LmMNCkBAIC0yMDk1LDYgKzIwOTUsNyBAQCBpbnQgYW1kZ3B1X2RlYnVnZnNfaW5pdChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikNCiAgICAgICAgaWYgKGFtZGdwdV91bXNjaF9tbSAmIGFtZGdw
dV91bXNjaF9tbV9md2xvZykNCiAgICAgICAgICAgICAgICBhbWRncHVfZGVidWdmc191bXNjaF9m
d2xvZ19pbml0KGFkZXYsICZhZGV2LT51bXNjaF9tbSk7DQoNCisgICAgICAgYW1kZ3B1X2RlYnVn
ZnNfdmNuX3NjaGVkX21hc2tfaW5pdChhZGV2KTsNCiAgICAgICAgYW1kZ3B1X2RlYnVnZnNfanBl
Z19zY2hlZF9tYXNrX2luaXQoYWRldik7DQogICAgICAgIGFtZGdwdV9kZWJ1Z2ZzX2dmeF9zY2hl
ZF9tYXNrX2luaXQoYWRldik7DQogICAgICAgIGFtZGdwdV9kZWJ1Z2ZzX2NvbXB1dGVfc2NoZWRf
bWFza19pbml0KGFkZXYpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92Y24uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0K
aW5kZXggMjVmNDkwYWQzYTg1Li45NjcxZGM4YmJlOWQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92Y24uYw0KQEAgLTEzMTgsMyArMTMxOCw3MSBAQCB2b2lkIGFtZGdwdV92
Y25fc3lzZnNfcmVzZXRfbWFza19maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KICAg
ICAgICAgICAgICAgIGRybV9kZXZfZXhpdChpZHgpOw0KICAgICAgICB9DQogfQ0KKw0KKy8qDQor
ICogZGVidWdmcyB0byBlbmFibGUvZGlzYWJsZSB2Y24gam9iIHN1Ym1pc3Npb24gdG8gc3BlY2lm
aWMgY29yZSBvcg0KKyAqIGluc3RhbmNlLiBJdCBpcyBjcmVhdGVkIG9ubHkgaWYgdGhlIHF1ZXVl
IHR5cGUgaXMgdW5pZmllZC4NCisgKi8NCisjaWYgZGVmaW5lZChDT05GSUdfREVCVUdfRlMpDQor
c3RhdGljIGludCBhbWRncHVfZGVidWdmc192Y25fc2NoZWRfbWFza19zZXQodm9pZCAqZGF0YSwg
dTY0IHZhbCkgew0KKyAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqKWRhdGE7DQorICAgICAgIHUzMiBpOw0KKyAgICAgICB1NjQgbWFzazsN
CisgICAgICAgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nOw0KKw0KKyAgICAgICBpZiAoIWFkZXYp
DQorICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQorDQorICAgICAgIG1hc2sgPSAoMVVM
TCA8PCBhZGV2LT52Y24ubnVtX3Zjbl9pbnN0KSAtIDE7DQorICAgICAgIGlmICgodmFsICYgbWFz
aykgPT0gMCkNCisgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCisgICAgICAgZm9yIChp
ID0gMDsgaSA8IGFkZXYtPnZjbi5udW1fdmNuX2luc3Q7ICsraSkgew0KKyAgICAgICAgICAgICAg
IHJpbmcgPSAmYWRldi0+dmNuLmluc3RbaV0ucmluZ19lbmNbMF07DQorICAgICAgICAgICAgICAg
aWYgKHZhbCAmICgxVUxMIDw8IGkpKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgcmluZy0+c2No
ZWQucmVhZHkgPSB0cnVlOw0KKyAgICAgICAgICAgICAgIGVsc2UNCisgICAgICAgICAgICAgICAg
ICAgICAgIHJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7DQorICAgICAgIH0NCisgICAgICAgLyog
cHVibGlzaCBzY2hlZC5yZWFkeSBmbGFnIHVwZGF0ZSBlZmZlY3RpdmUgaW1tZWRpYXRlbHkgYWNy
b3NzIHNtcCAqLw0KKyAgICAgICBzbXBfcm1iKCk7DQorICAgICAgIHJldHVybiAwOw0KK30NCisN
CitzdGF0aWMgaW50IGFtZGdwdV9kZWJ1Z2ZzX3Zjbl9zY2hlZF9tYXNrX2dldCh2b2lkICpkYXRh
LCB1NjQgKnZhbCkgew0KKyAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqKWRhdGE7DQorICAgICAgIHUzMiBpOw0KKyAgICAgICB1NjQgbWFz
ayA9IDA7DQorICAgICAgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZzsNCisNCisgICAgICAgaWYg
KCFhZGV2KQ0KKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KKyAgICAgICBmb3IgKGkg
PSAwOyBpIDwgYWRldi0+dmNuLm51bV92Y25faW5zdDsgKytpKSB7DQorICAgICAgICAgICAgICAg
cmluZyA9ICZhZGV2LT52Y24uaW5zdFtpXS5yaW5nX2VuY1swXTsNCisgICAgICAgICAgICAgICBp
ZiAocmluZy0+c2NoZWQucmVhZHkpDQorICAgICAgICAgICAgICAgICAgICAgICBtYXNrIHw9IDFV
TEwgPDwgaTsNCisgICAgICAgICAgICAgICB9DQorICAgICAgICp2YWwgPSBtYXNrOw0KKyAgICAg
ICByZXR1cm4gMDsNCit9DQorDQorREVGSU5FX0RFQlVHRlNfQVRUUklCVVRFKGFtZGdwdV9kZWJ1
Z2ZzX3Zjbl9zY2hlZF9tYXNrX2ZvcHMsDQorICAgICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1
X2RlYnVnZnNfdmNuX3NjaGVkX21hc2tfZ2V0LA0KKyAgICAgICAgICAgICAgICAgICAgICAgIGFt
ZGdwdV9kZWJ1Z2ZzX3Zjbl9zY2hlZF9tYXNrX3NldCwgIiVsbHhcbiIpOyAjZW5kaWYNCisNCit2
b2lkIGFtZGdwdV9kZWJ1Z2ZzX3Zjbl9zY2hlZF9tYXNrX2luaXQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpIHsNCisjaWYgZGVmaW5lZChDT05GSUdfREVCVUdfRlMpDQorICAgICAgIHN0cnVj
dCBkcm1fbWlub3IgKm1pbm9yID0gYWRldl90b19kcm0oYWRldiktPnByaW1hcnk7DQorICAgICAg
IHN0cnVjdCBkZW50cnkgKnJvb3QgPSBtaW5vci0+ZGVidWdmc19yb290Ow0KKyAgICAgICBjaGFy
IG5hbWVbMzJdOw0KKw0KKyAgICAgICBpZiAoYWRldi0+dmNuLm51bV92Y25faW5zdCA8PSAxIHx8
ICFhZGV2LT52Y24udXNpbmdfdW5pZmllZF9xdWV1ZSkNCisgICAgICAgICAgICAgICByZXR1cm47
DQorICAgICAgIHNwcmludGYobmFtZSwgImFtZGdwdV92Y25fc2NoZWRfbWFzayIpOw0KKyAgICAg
ICBkZWJ1Z2ZzX2NyZWF0ZV9maWxlKG5hbWUsIDA2MDAsIHJvb3QsIGFkZXYsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJmFtZGdwdV9kZWJ1Z2ZzX3Zjbl9zY2hlZF9tYXNrX2ZvcHMpOw0K
KyNlbmRpZg0KK30NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdmNuLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgNCmluZGV4
IDI3M2E5NGE1NDcyZS4uN2FkOTQ0Y2VhODYxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdmNuLmgNCkBAIC01MjUsNSArNTI1LDYgQEAgaW50IGFtZGdwdV92Y25fcHNwX3Vw
ZGF0ZV9zcmFtKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBpbnQgaW5zdF9pZHgsICBpbnQg
YW1kZ3B1X3Zjbl9zYXZlX3ZjcHVfYm8oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGludCBp
bnN0KTsgIGludCBhbWRncHVfdmNuX3N5c2ZzX3Jlc2V0X21hc2tfaW5pdChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldik7ICB2b2lkIGFtZGdwdV92Y25fc3lzZnNfcmVzZXRfbWFza19maW5pKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsNCit2b2lkIGFtZGdwdV9kZWJ1Z2ZzX3Zjbl9zY2hl
ZF9tYXNrX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0KDQogI2VuZGlmDQotLQ0K
Mi4yNS4xDQoNCg==
