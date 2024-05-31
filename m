Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026A5C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 07:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5599E10E05A;
	Fri, 31 May 2024 07:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qUIfpbco";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC0910E05A
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 07:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJ8gYGXjGgFl+vSUlGPzvblXGMMaVhaAlhc+Y4FzzfIv1xOBKkjSJFO6WEA7SVj0JF8lr48cCISQst5o1UhxXYfveUzz5iF8MGVIzCh2Il1Ik4gg2EWpleIve05GqX7dT2aBe3HHkeREbnTdV86Q0OdEDjt0LPtycceHKNtoVs/TNukD+hpeiKhBy448V2Oq6cY9eGNtqIAg3i9smpoXHM6CBxYqMcDcbCVXJ1M8Skjz7nr+cMgW+atlM6merBhs7NhOzzNt0JC2sVRqGmKRq9SdY/9h7QsFE+REMp8EBolWHCRgDL1OxyVzlKivkWQdavglDRSdf47J/nPDWvoPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rH16lj9fwFdG3YG5B6a7LxodjDO6zzCg42u8jcLuwMA=;
 b=Ibi4sgjR+Jw/KUa64L+VkqZbf5Zy6H6DDyAIogHMGY6lkOQvjJVkbiitDMnag0bWD41dCnb9qyBtDueME8cPaP6pYqB1BP9qpMOp0kHd872x+VCQYxH4pVr5Ny82AUsAzngdZLz+7HGpOm6NQxH+9RxYaTJsQIUUtl8RvNvAF9Rgyzw1u4hc4NnkFnLVztC0tq33AsMGsz5UzcFnxDv0Mx64pGo0WEmKJ8Sd9lCePOCySLCSo1b3SDSn2w4HHRsuqDCGRBHzvjEe34baHjq7WKzjQRggAU9GO5nV1XsDfAfpEkdrqx4x+5p9P6aHPxuiLG6Xe1QIDf2vlNXmxOL5VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH16lj9fwFdG3YG5B6a7LxodjDO6zzCg42u8jcLuwMA=;
 b=qUIfpbcoF0W747G0CwedLP/niAfMeF1msO10lk4n5j7x1F4Dof1J8lsBKQrMM2d2Ok2jomjMSYVFOk+BXEq2bM310PBUPQYAxPjEt+QB1mNL/Sg0oP5DERbGnnjvB+RzFEyl5FQ3PhEG77WSH/8PeB0rwILgxxmcuUM6QZ0akAk=
Received: from CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19)
 by PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Fri, 31 May
 2024 07:47:11 +0000
Received: from CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080]) by CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080%5]) with mapi id 15.20.7633.017; Fri, 31 May 2024
 07:47:11 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang, Tim"
 <Tim.Huang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amd/pm: add missing error handling in function
 smu_v13_0_6_allocate_dpm_context
Thread-Topic: [PATCH] drm/amd/pm: add missing error handling in function
 smu_v13_0_6_allocate_dpm_context
Thread-Index: AQHasy0h1NJMPB9LQkKo8oHH1rS93bGw9hWAgAAAhzA=
Date: Fri, 31 May 2024 07:47:11 +0000
Message-ID: <CO6PR12MB53948D0F74422F3BDFAD833294FC2@CO6PR12MB5394.namprd12.prod.outlook.com>
References: <20240531073531.20364-1-bob.zhou@amd.com>
 <PH7PR12MB599758A15F50AE3276276CCA82FC2@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB599758A15F50AE3276276CCA82FC2@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b77b6254-1b5e-481b-a5a9-696dae643fe0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-31T07:40:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5394:EE_|PH7PR12MB8040:EE_
x-ms-office365-filtering-correlation-id: 1b55c340-c15b-4454-952c-08dc8145e153
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?iso-2022-jp?B?RDMwOExDN2xHbFV4TVNVblBuRVdBSGhKM2N3NnVWK3NoT2Z5SzBoZjFC?=
 =?iso-2022-jp?B?Z013S0VwTUZWNGs2eHRaNll6YVZ1RkM4SFQ3MmZBaDNSSTVXeGpMa2NL?=
 =?iso-2022-jp?B?KzMyeE1iRzFCUlhsbDRZYTM1RUtVbnF3QkZHNzRycmVmUkdxOTV4dFBM?=
 =?iso-2022-jp?B?SWNrdTUrSGtKaks0RzMrNXVXcmlKQUtrRk1RVEIwV09jNTZ1Uk5aK0JZ?=
 =?iso-2022-jp?B?c1pZcmdLUmN3SjhQQ3BYcHAvejVpTWRrbmlVSmZ2a2IzeFJ0Y05oaHVa?=
 =?iso-2022-jp?B?T0tLcS91YVFrZVBnQmZJbElzb1VkYUlMMDFENE5DWDI4SG9VQVBrRDVT?=
 =?iso-2022-jp?B?amo4TExNWDVSZzlLV2h4SHI3YUVQSy82SDMvbzVuUXZPM3RFY2o4bjRX?=
 =?iso-2022-jp?B?L0hTT3I3LzFjQXVaZHhRaUhocno2dTF3V1dXdFhvWTU5OWdkdzdpWmV2?=
 =?iso-2022-jp?B?MFYrUUhrTlh4Y3lVOE1lSmRzTFFNbnFvU2QxZmxCUE1vZ1pmZlNVSkZ5?=
 =?iso-2022-jp?B?UVZpZHZVL2lZMnlNNFVzL1ZEQ3RNMEFNQTJVL0pOdmJCY2Y2OGtEVUd3?=
 =?iso-2022-jp?B?cW5JNzdIaSs0MmdJTitscldaN3NLZHpPTGJuYTREVlR2UE5makg1Rm1s?=
 =?iso-2022-jp?B?cDdzeUgvbkdSblFxY3UrbnBGUWJjNldsTGFvU3BzL3N4Mmp3cU1zUDkv?=
 =?iso-2022-jp?B?V3VwZU1XOVFvUm1NTjNrR2NaelJlWVVvVXUzcGZBYzFtV21kdmxSZUhi?=
 =?iso-2022-jp?B?UEpteEFuSXM5K2NzN3pRaGhCWnZ3NU56UzJMOS9hL05DcFRhL3BtWmxR?=
 =?iso-2022-jp?B?Y0d5Uit1M1NmQlJDNWxiWHFPZlFJeHhZajZKdnVuMUZQQW5VMy9RMGNr?=
 =?iso-2022-jp?B?eU5WbFNYNDBFZGk3MWZtV3VhK1pscEFhMlRtdElWSFR2aEoyTUplRkhG?=
 =?iso-2022-jp?B?SlhqZEFBMHhlc2tVcHBRZnJHVnBXam9LbDVUV3NnTnkxVmY1dTNlSzRZ?=
 =?iso-2022-jp?B?WnFZM0lqKzRrQTRvS0RkS0pYTSs4V1hiQmlLdTRnZnZuZ3UwaGcyVmRp?=
 =?iso-2022-jp?B?Qi9IMVJqb2k0cXN0VWdqMTlXdkNGMWliRFY2Tkg5ZFordU1vYkd2eVpy?=
 =?iso-2022-jp?B?c3lDd1hOTExoQWhTYXpNTVJ5MWp4RU50S05oZEc3WVByaGtXSy9KRDk2?=
 =?iso-2022-jp?B?R21MSWQwTkdTR29OcCt6WngzR2ZlV3hDQjlDb0ZoVU1YR25vQ2c2SVZy?=
 =?iso-2022-jp?B?THRGUVNUZ3FvUnFkUG9ZdE9QVTFudmJGNXZJQmo0d1hWYVlyYzlFeEIr?=
 =?iso-2022-jp?B?bmRmUlprUDVTWmdEOTFOa1dCNFhoZ1hGSDJlNHpxUVo4WGtjNmtUakRo?=
 =?iso-2022-jp?B?RnhBNW1sVnhwZnBhYkIrMWhJQm9UUWdRd2NjZFlOUDErNWJhS3hmcHJw?=
 =?iso-2022-jp?B?MDFWS1d6VkhudXVOYWg2Z1VJSE9yU3VDTVhrRDN6dm9Pbm4vUVVKV0xG?=
 =?iso-2022-jp?B?V2NGNFFvT1BwWHQ3MGpWQWFYWG1HdVdOd1doNUt5Zm9rejQ2eUZ1bFUx?=
 =?iso-2022-jp?B?MFRLVFJCNUR4Z0R6MzFLRWw3ZVNzKzFUcGZQcElORXhZNDgzVGl5WnQ1?=
 =?iso-2022-jp?B?TGhZUUxrOFpqOCtTQU9sRTlpQkpOWjJjSzRnK3dSbkNWWDZKUXZRMmVE?=
 =?iso-2022-jp?B?dnlLdWdxdFprNi8yYTRnSUxEWkdybjFMTWxyYTQxZ2lqWmI2TUJJTElV?=
 =?iso-2022-jp?B?ZTRtR3pUQk96WGppY0J5Vm9NNGUzWm1wMFFpOG8wZkVmVi9JNzEyNk5S?=
 =?iso-2022-jp?B?ZDN6MExQK29SZkFCYzY0YmNBaXNPVjMrd25oZ1N1Mlh4L05HZnNTYjVF?=
 =?iso-2022-jp?B?R3g1ckt3UzdFbk5hTDZlV0tRS2lCc2FXOWpKcklSTjFHU3k2U1pkZHNk?=
 =?iso-2022-jp?B?eEE1K0RiQU92WWZ4eGF6Sms5NDJEZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5394.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dFZwT2dpcHlNVmZMbnBGcUFvVTdqYzhTdVpNK1crd09iYk1mcVZSQTFU?=
 =?iso-2022-jp?B?YkZheVNiVkRMSllqTEZFdVYySFRLd2VNQmpJL1loUnNmSFU3Zm5kZmtX?=
 =?iso-2022-jp?B?ZEVwWHpNdHY2SWlaaDFFTjUwOTlRamdlUTZORFN3dkt6Zi9CUVMwVjdQ?=
 =?iso-2022-jp?B?R1NlMDZVc3JXd0lrOUdSMjR1b0RQK1pyemdyVjlLb0ZPVUE1ZGFrVnJi?=
 =?iso-2022-jp?B?YWE1VHRrMUFzQ1lEb1cwTzd1S3dCVVlYU29SSDRDeFhCMlVFREloYUJa?=
 =?iso-2022-jp?B?eFFIa1YzTlJyNjcvZUpJamFMUXJ0YmRER3dmdEoxbmUrbVJoa2RJTVRC?=
 =?iso-2022-jp?B?MGtYQlR1RDBSaTNYQWRoNXg5VUswQnYxNXR1TldvVENJR1Jpem5PMFZH?=
 =?iso-2022-jp?B?Sy9CTHRBWnJ1bkNTQ2hTcDFMeWRYQW5pWG9ub3RQWGErWTNpZTJmaHVj?=
 =?iso-2022-jp?B?dEdXTlY0T05IaXMwOGdtK0ZDdjhKZCt3a0tDNHowN2ZVT0VsbE5meUxh?=
 =?iso-2022-jp?B?dUFEODlkdFJPMjZUaExUU0FaQkZkMUhORFdVK0EreW9ZQU4ycnVsVzJs?=
 =?iso-2022-jp?B?eXhKZXg5aHR3Ly8reVc2UktzTmFOVUJsSWFxSFRzMWtFVWs2VnRwa0RO?=
 =?iso-2022-jp?B?OGhzMzJ5dDhVSGdvbGxXYVcvTmVSYVpZSFRDSEtlM3E4K1FYWW55QlND?=
 =?iso-2022-jp?B?UW96TU5jVlFqNTVoM1NDRXZjQ0F2TGhLcXg1ZXRGWTdqQmZjMmhtRHE3?=
 =?iso-2022-jp?B?UFpXa3VyVkRnREl0UUkyclBXQ1BPYldkdlR4UlVtbU5VZFk4bEpMRnpp?=
 =?iso-2022-jp?B?RXBHMDhJQW5NazVLMUhGQytiSWZSeVFOZlI3RnpDTCsrVjE2Z1N0RE5T?=
 =?iso-2022-jp?B?MTVpT3l0TlBkNUlKL2F4VzhkcGg3WnZTUjlPSjRUOGVHeW1ycHdlcDNS?=
 =?iso-2022-jp?B?ZXBpTmxHL0ZYeTRBREpSM0xiZGdNMEJEWDR6bG0rWG5TTGJ2bjFpaDlv?=
 =?iso-2022-jp?B?NFNvdWgrMURKTFVDaDlISy9Na2dydVlJU0FSMWZLakJ2cHVDUnJuUmhu?=
 =?iso-2022-jp?B?enpFbHF1RkVxakJzbWU4TVFsV20zdnFPY0ZYclRkYUZrcncvSGhNdGZ0?=
 =?iso-2022-jp?B?VlVmZzNaVDRRNmEvbVhnR3h2d0ErR21xTjd0U0lRQTJTUnJ6anZDckps?=
 =?iso-2022-jp?B?QTZBNld4SEY1YkpSNjVad2hOMFdGQ01hcUNsV1ppc052WEN5bkZ0SElG?=
 =?iso-2022-jp?B?cGVxUXdyN1Z3MC92dlRyZUhrYlc5aURLQk5mNnZaNC9SdDM0YTI3YkdW?=
 =?iso-2022-jp?B?V3FsRXNMb0NxT1EwbGZ6ZUtMeUpQZHdEVWNxYlA3c016Z1l6U3h0Sk8z?=
 =?iso-2022-jp?B?VlFCQ2VucVg3YjlNQmxHa1ViTTJsbEtSSU4vVVVFajliK0pTMUV0WXdP?=
 =?iso-2022-jp?B?NW9Kbjhtd0d1NzUxWkU2eHpKdENwNWJoWnExSEY4S29ycW1QSE5sd3Rv?=
 =?iso-2022-jp?B?YUpGcGY4dXVibjNJVjZYdW55dkxUdkt4VmF6eUpZbC9JTlNWNnVaS0xJ?=
 =?iso-2022-jp?B?TW1DL2FrN3FVaWtqVEJoRldwaVB4b3FwUHBVYUZCNGFFbjUrZTMydjBB?=
 =?iso-2022-jp?B?SldWQWRqVVJWMjl3ZkF6cm8xNTBDNU0wd3JpNDRaWWY2eWlWZkx6Z0FU?=
 =?iso-2022-jp?B?S0xoL0RMemVrZS8zd1hsZ0NaWnlZblI5K01lam1NR2wwbDNlUTJJYnhr?=
 =?iso-2022-jp?B?ckVtRWhrckkwL3Fhd0J4dzFSNWRFVUlrUU5mZGRJY2p6OUJ2MjdzVzgz?=
 =?iso-2022-jp?B?OVpPK1B0NlJLUzZoTEpxVDlzZHhXdjMrOWQ2U3JyS0FsK1dtRTY2ak85?=
 =?iso-2022-jp?B?aUgvRnZlZHV4SDUwRWN6Tjc0YzhrRXdXTmpuMDlJY0V1VytzLzE1dlZs?=
 =?iso-2022-jp?B?eXkrWXlLZm9ZMEhxS2IvWXJxZHI4K2dnTUpLTC9IanM3alovS0dHQmE5?=
 =?iso-2022-jp?B?LzZzK2x4RmRaMmxuZi9MeTRnV1NNQlRQNTdqOWNxajhJT1ZSNlYyOGVx?=
 =?iso-2022-jp?B?N1ZERC9YMTNQa3ZrcGdodGU4ejlnNVpUSnlCdjhVd3RhYzhkQTBPKzlI?=
 =?iso-2022-jp?B?dkswbVlFSis3TkkyTzZXSGdvYmsxQlRDZlY2K1cxdGJjYzZlUWp5dUZ0?=
 =?iso-2022-jp?B?RXFqS0t3ZGlIZWVBb1RoZ2pSQXRIYU1oclJ3aXNabjFEV2NvbVZvRklx?=
 =?iso-2022-jp?B?RHVlY1ZGSm03aWdkSlNMdTZOWnVOVGgwZz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5394.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b55c340-c15b-4454-952c-08dc8145e153
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 07:47:11.2468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZrXgG04bxHcc4UdkxemcB31tIpF6KaIq0LNCcFOb9AZuhSg6DSJteO2FyjbyblheyXiGrbRb/S+Ry8qGdg4fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040
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

Good catch! Thanks for your comments. I will fix this on next patch.

Regards,
Bob

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: 2024=1B$BG/=1B(B5=1B$B7n=1B(B31=1B$BF|=1B(B 15:43
To: Zhou, Bob <Bob.Zhou@amd.com>; amd-gfx@lists.freedesktop.org; Huang, Tim=
 <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhou, Bob <Bob.Zhou@amd.com>
Subject: RE: [PATCH] drm/amd/pm: add missing error handling in function smu=
_v13_0_6_allocate_dpm_context

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bob Zhou
Sent: Friday, May 31, 2024 3:36 PM
To: amd-gfx@lists.freedesktop.org; Huang, Tim <Tim.Huang@amd.com>; Zhang, J=
esse(Jie) <Jesse.Zhang@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhou, Bob <Bob.Zhou@amd.com>
Subject: [PATCH] drm/amd/pm: add missing error handling in function smu_v13=
_0_6_allocate_dpm_context

Check return value to avoid null pointer dereference.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 15c0aa0ad443..419e46cfa065 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -451,6 +451,9 @@ static int smu_v13_0_6_allocate_dpm_context(struct smu_=
context *smu)

        smu_dpm->dpm_policies =3D
                kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
+       if (!smu_dpm->dpm_policies)
+               return -ENOMEM;

[Kevin]:

the 'smu_dpm->dpm_context' needs to be released together to avoid memory le=
ak.

Best Regards,
Kevin
+
        if (!(smu->adev->flags & AMD_IS_APU)) {
                policy =3D &(smu_dpm->dpm_policies->policies[0]);

--
2.34.1


