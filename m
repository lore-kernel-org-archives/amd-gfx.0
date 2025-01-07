Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC03CE77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 04:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F31A10E132;
	Tue,  7 Jan 2025 04:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K37RkKd5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C74710E132
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 04:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUAWFYixTNJKKrMAGLNPjfLN6NCXQqRLglOcFA75Q+pCjv/Z6iT22+gs3W72cB1DswJoyPsSK51oy1damrcbaaGYdkT6t++ZiOABFAkR4cCG9u9cb/b+Eq6kGcZgyJ3fOA2RJCtnhtUvV6kDEYneEdZusvCBvOk+V+CciUIJguxBBjzEZBSqY5v73Vqxo2CLW8OktZUcuepcPHPPYjwdqhx/+9e44PDWem49ou0fqt12AH2nKCFtPS/sPbzD4OEj53bt0f1+UV9ofTbmuSpjmXJ+HR05PiJMdTyhuy+eyTvshvowyChb0X1yvClfXduscaSBPj/w7PC0vC4a0nv1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lijMbWqPLrlL4iNZkolpT0kWiVmS/xTJpUqMpvFpStQ=;
 b=sT8ji9RaVotNmZrt0K+BrtHaF3UxynpcaUQtN2p/XEWwdq5R7TaurnRBVL3Pgipwh5Ks3XQgw3+oVgzNAcIbxRQMsiNizRyXb7yypVo1F9dELor+fJmo6nPfBKp4CRXDr1cRkIPWJ0EzLZuWCAZ9Db4wgZKNb/VxtlF0Op//zqOXIEBw08j6SK1lN6rxJavZVu7kdz1bVsI0zOmuRYWE44Ekivma80GKAbfqHXiBv1nz/ION4tBHkUzknsN0wLei4h9J/8yGiUgkj5idXu6V1kcRQL0c4Hds1E3uzIhe4iur7eWjSn9xZQJ8KIYaxw2UNBrrSn2vcQAgAIrFr0jaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lijMbWqPLrlL4iNZkolpT0kWiVmS/xTJpUqMpvFpStQ=;
 b=K37RkKd5VuzQX8tWdBzCo7TfJ18bJsFb6fwt8zAFV0AUNoDS171CiSvGfRG2B5GrKsjbx6FI/JlY03/Bc2GsflycsQK54U6aDdCUwBtG4nYDYKQyDOAQy1oYwgz3LrN6L9e/4vcn7Q1/XWH+VHhyD3YU4IqoILlohereRaoq+8I=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 03:56:16 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%2]) with mapi id 15.20.8314.013; Tue, 7 Jan 2025
 03:56:16 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Pillai, 
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: add the interface to set and save the
 bootup workload type
Thread-Topic: [PATCH 1/2] drm/amd/pm: add the interface to set and save the
 bootup workload type
Thread-Index: AQHbVqQpv4Qv+641QkqMlwLQY7vvBLMJ+maAgADH0tA=
Date: Tue, 7 Jan 2025 03:56:16 +0000
Message-ID: <DM4PR12MB5165696C5A07E1ED7845E53E8E112@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20241225080814.1692482-1-kenneth.feng@amd.com>
 <CADnq5_NT7mC--R=pSo62riPD05cVwzmXwKzakWWKnaU=sgduBw@mail.gmail.com>
In-Reply-To: <CADnq5_NT7mC--R=pSo62riPD05cVwzmXwKzakWWKnaU=sgduBw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=cfbf7107-3e6e-4cfb-b89b-6fd85d5a25bf;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-07T03:53:46Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|SJ1PR12MB6050:EE_
x-ms-office365-filtering-correlation-id: 76b27e5a-045b-433a-67ee-08dd2ecf3c92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b3BQQTRBSTlkWUJUNHBOTnp2cTY2MzA3R1hLV2xlWUR5eXdLNCt4R0VzZHl2?=
 =?utf-8?B?UVJJRzJBcHYwZXZoNHJraDhvN1JKU1BCVGgwMUNBS01NRWMyMWZUTTFYWVFF?=
 =?utf-8?B?ZHpuOW1RTFA5bHM0UkNOY05JT0FGQVlnd1ZHUEgvbXNhdWpKM2FGY0NpSUFH?=
 =?utf-8?B?UE4vbU1MeTlEY0g4cWpSMXQrcDBvbVZyS00ybEpRaGVOM2pMbzBBUjU1aVFs?=
 =?utf-8?B?V3o5bHBtZnlPb3B5WlNVZ2RDUWxPUldhSGE3L0dlaGxEcm5QQ2FBbklUV0FE?=
 =?utf-8?B?ajF0Qi9LMTFPazlhQlc3Z1A5eGo3UkhTNDM5aGFHR3NCcyt5dnFSTTY1dXlT?=
 =?utf-8?B?L2pXUmNXNVFsUENVVW0ya1c2Vm12dGw2NXdSemNmSCtLLzRmQzQxZ2NyNE5T?=
 =?utf-8?B?a0NmbmIvZFNrRk9iQUZQa3lya1BoS1M4UDQ1eXlvNGtaQzZvVUVYQzZyTUh5?=
 =?utf-8?B?aVgzcjRoUTYxRWNCTVBCV0tNY3E0dlVqT1NwWFJyc3VFbHRuT0piN1FvLytD?=
 =?utf-8?B?NjVqM3A0N2JJL1ZxMXpYMjlEY1p6TUVHM3B5VDlVTEYvRm0zSnh2YlU2Uk1u?=
 =?utf-8?B?bkJXMjFMSXpxZGlsRkNFWHVnMDRJbEtRT21tTDRSL2hiRERER1lnNHdwbHdY?=
 =?utf-8?B?WlJBdWh0czBTU3k5VExWVHJZZjQrUThwMFd2ZnQ2aXJNU3Y0UWtkZytwd3pM?=
 =?utf-8?B?NDBhL24waUN1SlZJaC8rN1FidGhCdDJjd2VjWk9idTBURjJQdHovZUR5WnV6?=
 =?utf-8?B?OWdxT3dMUng1RkczNnFZMk4rZTVsMjlPVXdoMTBEUnVzcWY2TkVlWGVoNmRx?=
 =?utf-8?B?aFlZYitkK2RPZEJFZTNKU29SbzZ4b0pNRjRLYkxUWmVVL2twUVhJSC95UGNt?=
 =?utf-8?B?d3I1emxoTDgvaUNKVXllUEZGZEY4V1dSbGMwZ2U3OWUyVEJrcWlSYjZ3SUIy?=
 =?utf-8?B?RlpkRGhRLzBGUU1mbThlS0hWVEMxUVZSY08zVEk1cmd6VStVZGlmYk95WDF4?=
 =?utf-8?B?Y3lQSjd1UU1nUkNoWlFWdmFSYVdNM1RpOVJZRnBYbEJUMWZHUkljQnRvM05L?=
 =?utf-8?B?Q09TWTZtMGtiSklCa1ZocTg4TjZtcHdDSlZObFdCd3Axbm5GeXRWN09VdGxL?=
 =?utf-8?B?YnNYY0Z1ZEd0NWhqb3Z2MWRZWUc3OHRuOXI3eVRoWHRsbUo3NFRFbnRZNGJw?=
 =?utf-8?B?dVpXbDVIV3RRR2F5UjMrSklMM0lIQjlqUHBaUnhKQ3lld2czQkVpUmJaeTJF?=
 =?utf-8?B?V0N1QWE0WDJTMEFKMzZQMHdEZXRBYjdwV2RRK3pvSStUTzV4Mmg2V2UydlVF?=
 =?utf-8?B?ZzdFeGZRb0tiSkR6TzRsNGt4MWR4YktiY0ZCYXlzQ0ptMHhzNG4wQXM5SitZ?=
 =?utf-8?B?K2hUUS9LZGtjeVVFVmxxMnd3OUhsWkh3bnFhZmo0cFVRRXB3SjI5Qmtoc0Z4?=
 =?utf-8?B?NjNudU02V29sT0YzYzFmalBvQ0ozSHphVFEwOVNZTFNpdXQ1UkNKdVJGOXll?=
 =?utf-8?B?WXRzUXdVN0VpQktvRWprZUl5ejdSR2t6VGZINjBpNFNIOWtPRnpvN3dMS1J5?=
 =?utf-8?B?MGxGSkJaMzkwM3ROY1U4UjQzRE91cnk3cU93RDVpOWg2ZEdlYnBuQ3lLVHpU?=
 =?utf-8?B?RndpSDB4WHZlcWs2V0MzNEdlRFVEOXZmZWlOSGlMZzZXTWVUendhWlNQS3Fy?=
 =?utf-8?B?bXo2RG1ZOFBSMW5zT3BLamZRWldUY0M3UHpoUk9TV2lFVEpqa0ROd0ViaUNE?=
 =?utf-8?B?TStRdnlZeEVNRDdPWldhdE9tazIzbnhzbGkyMWRYdmxQamkvQXB4eElMOEN1?=
 =?utf-8?B?RlhtbC9vVVY3b3dsc0Q4RUZtSnFtNXRnQ0tGZnZPUWF3bmlZNGZCdm1VV1o4?=
 =?utf-8?B?eE9kbmc2OXFjdWQ4cEdzZ0pFR2JHbEU5eTlXZWwxcnd4ZGtXeGpEVVZtOHlQ?=
 =?utf-8?Q?TOYedDWUbMwugL0JRLEFTeVZopjKmMKo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHZqeERQWlhSTiswcElOajRld2FJYlphNmhqV1lFMUtnVzBBcnJDK09UbVBX?=
 =?utf-8?B?dG8rNVVZTld0R2wxcDhMMUdjV1VxMnJCTmZTT2d0ZzNWSElsbXdGQTBVOXdG?=
 =?utf-8?B?dXdiMzZFOGl2Q0w2QUh1K1ZpeTlXYmNVY0dLbi9iOWpOWDlOZTlmandLeUMw?=
 =?utf-8?B?MnIrb0toK0RTWjBZeHpMQWczU1BHS3p2QTA2dzJEOVRyNkQ2MlhiQk1LYnFr?=
 =?utf-8?B?NUdlTXRaWUtjVzZQWUNha09RTitMam0xalZOWUkyK2JodHBFdFVjY1EwRkdC?=
 =?utf-8?B?UnFYZ3RaZ3NGbStnV08wbzU2SG1vTlNBYkE4a2lXWS8zRGFJMktUSXlaWExl?=
 =?utf-8?B?enA4N01PSmloSnRJQVFabFZNM3FGWmlUdjB2N1pqd1dDWGk1dUxMS29lT010?=
 =?utf-8?B?UkgrUkhQV2hXOWNTMnNSYkdtT3JhQmxLVm15VlljYnJpZHR2eFFodm1Fakd1?=
 =?utf-8?B?WlNxU3VXS21nbVhWeVdPMHk0Z2lpT0lVbGZiUlhkRWQxa3I5WUh2RnU5RDdi?=
 =?utf-8?B?WldMMzNDdjlsQXIzY0I4ZDViem1LQzhUbmFTZmpKeXJNdU1ZeWlDVWVLdEV0?=
 =?utf-8?B?OVVsQjJVYWxxVXZCK0l6aDFWUmtMZnM1USt5RWFiRzQzWURZck9hczRMZ1NZ?=
 =?utf-8?B?M2ZkSFgvK0Y0aTR4UW5GYVBIM0Y4ZmttOWZYQVJaanpHNUVkQVQxdTVkME9n?=
 =?utf-8?B?a1Jldm53NmNqYXBkTWlRUy9Rc3A2SWY5WE1MSUZUdmV0T2xmaThvczBRVEt6?=
 =?utf-8?B?TmxDVlZzd0ZYRkVDYVZqTy9PVUdtek1iL1dyWEdNdlZ6dkFFdTh5VTRmR1B0?=
 =?utf-8?B?YlJzUjVyRmVWa3B1eml2VkNpMngzMzlpZXllKzhMTm9YaEFBYmJ4YnlnVWFN?=
 =?utf-8?B?WDVvQ01rN0pUdklxb3dHUFVhRzd0RWNuYUZhQ1pvdGtvK1dmeFhzQlBqTVRl?=
 =?utf-8?B?dnRVNS9wR1ZJQ2F1QmNOR1BrZHd0a1FNM2V0VTczSUY2bVFOYmdlL3gvaFRx?=
 =?utf-8?B?aytKa3BHVW9WRnNMU3RVTEFuYVh4cmtQb2IvM3YwZEoyc2tqWTErdXFZaVhh?=
 =?utf-8?B?a2FpMi9TbGVGS05tQzgrTXdVTkNPNWtCYS93MkFEUTlBQ0ZnMkt4RHBnMXo5?=
 =?utf-8?B?d3FzbENXS0VGRXRJUVB5WlV3dDJ5YkxzaG81a0UyVWNvQTAwZFJlRzlCdEJK?=
 =?utf-8?B?SUVOQ0tQMlJyZkw1K1lkaWx6UThYOW1DN3gxQWFPWHZtOHNnU05HS3VMZVR1?=
 =?utf-8?B?eGhLNkVEZGkzSHQ5cXhvNGNxdElvUmwwQmpVdEZNMTBVTGVNblYvRHBiWXdN?=
 =?utf-8?B?cWhJSWlxQnlhT3NiTTZ4TnAvak9GQ1Jsb2plZEZwaDFhaTFYRERySDVXQVFC?=
 =?utf-8?B?YXpiMXdZY2xDN0lGak5TY1BiSDVRTFV2N2t3aXZEbGtGbnZ6bklTazFZWHVY?=
 =?utf-8?B?dFhCY2d3RVJtYWQ5d3hhR0FsU2Y3czVEWi9ETlc4clRCc2gvS2VRSGVFRzJt?=
 =?utf-8?B?WTBLNGxoOURwZ1h2dlBnYmVYSzhuSGZlSU1LdGdtZHo2OVVjYks1bFpvcWp2?=
 =?utf-8?B?WVd0WUJ3cCtoZmlEY0xoem11UGRWR1VPeDIvZFUvMDZWVm13U01lMDZxUnNC?=
 =?utf-8?B?RnNmc01CcTFhUURzU29rN3VKdG9lbEUwVXY2UmFsZnNoQ1JyS05DQy9wTUdp?=
 =?utf-8?B?VlJKY05KRk51SWpTOHVXKytjbjdpUTB2dDV3ZGhQa1crK1BueFFQNW0wNHpT?=
 =?utf-8?B?QU5YNjZiZmttYno3RHA0NFQ3M2lpWXNwcFNwbVg3MkY4QjR1SFRHTW5WbkVF?=
 =?utf-8?B?Y3pIQzgxOU95YUY4b1FvMVp1MVdRUTM3RDVydndHajRXVENWUjFNNTZsQzAx?=
 =?utf-8?B?S3NJb2VNYVNXakdtL3I4OWtSd2x1U1dHVDFZdTAzNjFOeDBlTmYybFVHU01P?=
 =?utf-8?B?L3NoZURNdmNJMmw2QkR4MUhlT25UQXhNN09nMTYxVHhUakFrdVBzblVUT1lQ?=
 =?utf-8?B?bUFITEUvZmpPdnFleFN4YzMzZnVrN3YrVWFJU2ZKbThFT0w5QTd3ZVcxUGhp?=
 =?utf-8?B?WWxjSUo0NnVUR0xXUStCR05lOGRhcVYrai9KYmxUSGhaNFJYa3pYYjQxS2Jn?=
 =?utf-8?Q?DG1w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b27e5a-045b-433a-67ee-08dd2ecf3c92
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 03:56:16.5207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+qMJNqHXJq04iY73RJq2GfPslqWfcvVXKrvyI98Nfwijlr9EwgyCaOaTikKLRe+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRl
dWNoZXJAZ21haWwuY29tPg0KU2VudDogTW9uZGF5LCBKYW51YXJ5IDYsIDIwMjUgMTE6NTkgUE0N
ClRvOiBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgUGlsbGFpLCBBdXJhYmluZG8gPEF1cmFiaW5kby5QaWxsYWlA
YW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4N
ClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkcm0vYW1kL3BtOiBhZGQgdGhlIGludGVyZmFjZSB0
byBzZXQgYW5kIHNhdmUgdGhlIGJvb3R1cCB3b3JrbG9hZCB0eXBlDQoNCkNhdXRpb246IFRoaXMg
bWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNh
dXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9u
ZGluZy4NCg0KDQpPbiBXZWQsIERlYyAyNSwgMjAyNCBhdCAzOjA44oCvQU0gS2VubmV0aCBGZW5n
IDxrZW5uZXRoLmZlbmdAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IGFkZCB0aGUgaW50ZXJmYWNlIHRv
IHNldCBhbmQgc2F2ZSB0aGUgYm9vdHVwIHdvcmtsb2FkIHR5cGUNCj4NCj4gU2lnbmVkLW9mZi1i
eTogS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZlbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYyAgICAgICAgICAgfCAyNyArKysrKysrKysrKysr
KysrKysrDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfZHBtLmggICAgICAg
fCAgMyArKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jICAg
ICB8ICAxICsNCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvaW5jL2FtZGdwdV9zbXUu
aCB8ICAxICsNCj4gIDQgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfZHBtLmMNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYw0KPiBpbmRleCA2YTllMjY5MDVlZGYuLjkyZmEx
OWNhYzMyYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfZHBt
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfZHBtLmMNCj4gQEAgLTM0
OSw2ICszNDksMzMgQEAgaW50IGFtZGdwdV9kcG1fc3dpdGNoX3Bvd2VyX3Byb2ZpbGUoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gIH0NCj4NCj4g
K2ludCBhbWRncHVfZHBtX3NldF9hbmRfc2F2ZV9ib290dXBfcG93ZXJfcHJvZmlsZShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYm9vbCBlbikgew0KPiArICAgICAgIHN0cnVjdCBzbXVfY29udGV4dCAq
c211ID0gKHN0cnVjdA0KPiArc211X2NvbnRleHQqKShhZGV2LT5wb3dlcnBsYXkucHBfaGFuZGxl
KTsNCg0KWW91IG5lZWQgdG8gY2hlY2sgaWYgaXNfc3VwcG9ydF9zd19zbXUoKSBiZWZvcmUgYWNj
ZXNzaW5nIHRoZSBzbXUgY29udGV4dC4NCg0KPiArICAgICAgIGludCBjdXJyZW50X3Byb2ZpbGVf
bW9kZSA9IHNtdS0+cG93ZXJfcHJvZmlsZV9tb2RlOw0KPiArICAgICAgIGludCBzYXZlZF9wcm9m
aWxlX21vZGUgPSBzbXUtPnNhdmVkX3Bvd2VyX3Byb2ZpbGVfbW9kZTsNCj4gKyAgICAgICBpbnQg
cmV0ID0gMDsNCj4gKw0KPiArICAgICAgIGlmIChlbiAmJiBjdXJyZW50X3Byb2ZpbGVfbW9kZSA9
PSBQUF9TTUNfUE9XRVJfUFJPRklMRV9CT09UVVBfREVGQVVMVCkNCj4gKyAgICAgICAgICAgICAg
IHJldHVybiAwOw0KPiArDQo+ICsgICAgICAgaWYgKCFlbiAmJiBjdXJyZW50X3Byb2ZpbGVfbW9k
ZSAhPSBQUF9TTUNfUE9XRVJfUFJPRklMRV9CT09UVVBfREVGQVVMVCkNCj4gKyAgICAgICAgICAg
ICAgIHJldHVybiAwOw0KPiArDQo+ICsgICAgICAgaWYgKGVuKSB7DQo+ICsgICAgICAgICAgICAg
ICByZXQgPSBhbWRncHVfZHBtX3N3aXRjaF9wb3dlcl9wcm9maWxlKGFkZXYsIGN1cnJlbnRfcHJv
ZmlsZV9tb2RlLCAhZW4pOw0KPiArICAgICAgICAgICAgICAgc211LT5zYXZlZF9wb3dlcl9wcm9m
aWxlX21vZGUgPSBjdXJyZW50X3Byb2ZpbGVfbW9kZTsNCj4gKyAgICAgICAgICAgICAgIHNtdS0+
cG93ZXJfcHJvZmlsZV9tb2RlID0NCj4gKyBQUF9TTUNfUE9XRVJfUFJPRklMRV9CT09UVVBfREVG
QVVMVDsNCg0KU2hvdWxkIHRha2UgdGhlIHBtLm11dGV4IHdoZW4geW91IG1lc3Mgd2l0aCB0aGUg
c211IGNvbnRleHQuDQpbS2VubmV0aF0gLSB0aGUgcG0ubXV0ZXggaXMgdGFrZW4gaW4gdGhlIGNh
bGxlZCBmdW5jdGlvbiBhbWRncHVfZHBtX3N3aXRjaF9wb3dlcl9wcm9maWxlLiBEbyB3ZSBuZWVk
IGl0IGJlZm9yZSBjYWxsaW5nIGFtZGdwdV9kcG1fc3dpdGNoX3Bvd2VyX3Byb2ZpbGU/DQpUaGFu
a3MuDQoNCj4gKyAgICAgICB9IGVsc2Ugew0KPiArICAgICAgICAgICAgICAgcmV0ID0gYW1kZ3B1
X2RwbV9zd2l0Y2hfcG93ZXJfcHJvZmlsZShhZGV2LCBzYXZlZF9wcm9maWxlX21vZGUsICFlbik7
DQo+ICsgICAgICAgICAgICAgICBzbXUtPnBvd2VyX3Byb2ZpbGVfbW9kZSA9IHNhdmVkX3Byb2Zp
bGVfbW9kZTsNCj4gKyAgICAgICAgICAgICAgIHNtdS0+c2F2ZWRfcG93ZXJfcHJvZmlsZV9tb2Rl
ID0NCj4gKyBQUF9TTUNfUE9XRVJfUFJPRklMRV9CT09UVVBfREVGQVVMVDsNCg0KU2FtZSBoZXJl
Lg0KDQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAgcmV0dXJuIHJldDsNCj4gK30NCj4gKw0K
PiAgaW50IGFtZGdwdV9kcG1fc2V0X3hnbWlfcHN0YXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcHN0YXRlKSAg
eyBkaWZmIC0tZ2l0DQo+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X2RwbS5o
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X2RwbS5oDQo+IGluZGV4IDFm
NWFjN2UwMjMwZC4uNWZlNDA0YmJiMDMzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL2luYy9hbWRncHVfZHBtLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9p
bmMvYW1kZ3B1X2RwbS5oDQo+IEBAIC00MTAsNiArNDEwLDkgQEAgaW50IGFtZGdwdV9kcG1fc3dp
dGNoX3Bvd2VyX3Byb2ZpbGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0gUFBfU01DX1BPV0VSX1BST0ZJTEUgdHlw
ZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBlbik7DQo+DQo+
ICtpbnQgYW1kZ3B1X2RwbV9zZXRfYW5kX3NhdmVfYm9vdHVwX3Bvd2VyX3Byb2ZpbGUoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJvb2wgZW4pOw0KPiArDQo+ICBpbnQgYW1kZ3B1X2RwbV9iYWNvX3Jlc2V0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KTsNCj4NCj4gIGludCBhbWRncHVfZHBtX21vZGUyX3Jlc2V0KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsgZGlmZiAtLWdpdA0KPiBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9hbWRncHVfc211LmMNCj4gaW5kZXggOGNhNzkzYzIyMmZmLi5hNmY3NDgzNjExOTggMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jDQo+IEBAIC0x
MjcyLDYgKzEyNzIsNyBAQCBzdGF0aWMgdm9pZCBzbXVfaW5pdF9wb3dlcl9wcm9maWxlKHN0cnVj
dCBzbXVfY29udGV4dCAqc211KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBQ
X1NNQ19QT1dFUl9QUk9GSUxFX0ZVTExTQ1JFRU4zRDsNCj4gICAgICAgICB9DQo+ICAgICAgICAg
c211X3Bvd2VyX3Byb2ZpbGVfbW9kZV9nZXQoc211LCBzbXUtPnBvd2VyX3Byb2ZpbGVfbW9kZSk7
DQo+ICsgICAgICAgc211LT5zYXZlZF9wb3dlcl9wcm9maWxlX21vZGUgPSBzbXUtPnBvd2VyX3By
b2ZpbGVfbW9kZTsNCj4gIH0NCj4NCj4gIHN0YXRpYyBpbnQgc211X3N3X2luaXQoc3RydWN0IGFt
ZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spIGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3N3c211L2luYy9hbWRncHVfc211LmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L2luYy9hbWRncHVfc211LmgNCj4gaW5kZXggMzYzMDU5M2JjZTYxLi5jNThmYzMxZmIx
ZDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvaW5jL2FtZGdw
dV9zbXUuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9hbWRncHVf
c211LmgNCj4gQEAgLTU2MCw2ICs1NjAsNyBAQCBzdHJ1Y3Qgc211X2NvbnRleHQgew0KPiAgICAg
ICAgIHVpbnQzMl90IHdvcmtsb2FkX21hc2s7DQo+ICAgICAgICAgLyogZGVmYXVsdC91c2VyIHdv
cmtsb2FkIHByZWZlcmVuY2UgKi8NCj4gICAgICAgICB1aW50MzJfdCBwb3dlcl9wcm9maWxlX21v
ZGU7DQo+ICsgICAgICAgdWludDMyX3Qgc2F2ZWRfcG93ZXJfcHJvZmlsZV9tb2RlOw0KPiAgICAg
ICAgIHVpbnQzMl90IHdvcmtsb2FkX3JlZmNvdW50W1BQX1NNQ19QT1dFUl9QUk9GSUxFX0NPVU5U
XTsNCj4gICAgICAgICAvKiBiYWNrZW5kIHNwZWNpZmljIGN1c3RvbSB3b3JrbG9hZCBzZXR0aW5n
cyAqLw0KPiAgICAgICAgIGxvbmcgKmN1c3RvbV9wcm9maWxlX3BhcmFtczsNCj4gLS0NCj4gMi4z
NC4xDQo+DQo=
