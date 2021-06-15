Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6F9C48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 11:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0336145D
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 11:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0336145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1DDD89C51;
	Tue, 15 Jun 2021 11:59:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C15BC89C51
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 11:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoAlHXozwjNutSuAmhHCFUdAVCpu/gLuyZTcGA63T0dVYiJKsRzw7w4cRgFDln0cgtUBwWjulwyaFfxWNQQUY4Wcrm5LpCqVfZQG21RQb4ExtK+BKgI6RPXsVB2ilAB1tSedu+iw17cKLpBlhj29VpyxLM8mEX1agkJV2d3c9dS7oJMi8qfV845bFI6qHuLGUB2bRqN7QQk5piFqxcAhpboxrHUd11JjhczU43A67p+dS254FKq76loVHRJy/j7IDOOL6uqJAKCxuVNmfazw53C9yN8ssRsODp1HWfT7tuhJii/g7kUiSWT3hO5k/1Y7OOVtM8vIYbVLa2vcRckEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86mgXUiuTRPiYoIZcmTTmGErNZN294s/Vgu3cd/yPcU=;
 b=F0vPNPnvh6pxbs+GoGw6P6afV12TWFYwRiukJjOu0qGp8zb8GT2xo3JsTZmGaKdaAnRU2xzcGN6G1tiGc8mqveT8qkjTvbw78abneyvxTor/VtevRgTTRzQXHoBwnFrwR1woOtO/Ptq1VFSCkqzM2YHbgCXVQgOx18WyxStw8g5VoJhEYQknZ8J+wkN2ELG2J57yh1Th8fDW5WIXd6hU3IUdC+vRl48EA4S91PsHLYgUiU12Zuw3keWVzNNubtFBR8vROeE+T+ElaFyGyRt66UP9g/pIGHRiayir2kJ7PioPFRhq4L0sKvKsR1gt9Uh7F94cLogvymcZxJxAdIZn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86mgXUiuTRPiYoIZcmTTmGErNZN294s/Vgu3cd/yPcU=;
 b=vt/Zy8IZS9h2a1K46Xg7Q9MRB/xVzA+zj3Vw4UM79PgADtGhtkTXmO9zV4bXo8kQ3IU1nq8A/sc2/MQsnv2FVAqcNfuB9GFVn28ovCirvZR3PamEhai85czny9ksIIKfroUoJfuAphC1m0Vj2qCkGRMv3YNwB8Q3LoN7eayjVJY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 11:59:16 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 11:59:16 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: move shadow_list to amdgpu_bo_vm
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210615115112.50301-1-nirmoy.das@amd.com>
 <20210615115112.50301-2-nirmoy.das@amd.com>
 <a1a9f8aa-eb22-afd0-f893-bb340b990894@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <efea1859-825b-4b5f-29b5-8315bc110706@amd.com>
Date: Tue, 15 Jun 2021 13:59:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <a1a9f8aa-eb22-afd0-f893-bb340b990894@amd.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f25:c00:389e:e320:3bf5:cf96]
X-ClientProxiedBy: PR0P264CA0195.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::15) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f25:c00:389e:e320:3bf5:cf96]
 (2003:c5:8f25:c00:389e:e320:3bf5:cf96) by
 PR0P264CA0195.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 11:59:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cad2de55-d12e-44f6-9869-08d92ff4ffde
X-MS-TrafficTypeDiagnostic: DM4PR12MB5263:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5263465BF072B6D19266A1B38B309@DM4PR12MB5263.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBVrTmV4Yux2nWD1OdnZhOVz9MG/us5cUnEAY1+ixUvKOUX6TN/y9H5DmfU6q3F3XR+DlP9lEfpgpXrsDvXYTHjF1RqYCaBUUzU4OSL6I45n9vMWTKISwI2QP5ytMSv/LSfltRYgwK4oCqN7Ffv5Zqj8NxMJiokI2+XFDbg7UA+tEYRSizU43IR1ujembqN3b1hlKAwMR+eTki7j6nU0Zc5acWK4Itb1xyKQTRAgDKuudmXF9APhws52ketqAue8YLKBnh8mLu610RsDJarMfaAUF3O0zl1U6TaLldjc8Q20BhMoyH+jegIJ35VCGE3Q6Tkw3jY89mdNL3ccuHIwIAS8iQemg7MAKOlbbiNqxte07c4CCYFtBOClPoFdEaykf3YC+m/q66P4aIJhuz+aiinSQh+Fe4zKEvSGP7gKiSnACwBvxROutygVM2cuvRaYbXotStJ1Thbq1Y+U8r1v4pL6bSEV/C+iDdPY/8hPQkC94+Hn8YJRMT/gN+1AUZZWlebtlt3gMG6ipd4vw4+x/4CUwyr6DuZZTDOvqGkf3dJwzwikmPDYrdA/nwAJRv5ItkZATSlBWyc6g9y5K092gXH+kLMYNsUdiX7QgHvVWuqRpA7Owllk6/1DIzG1xFHQen4FO0u8z3MjKdQphcE0Kb5R/myddq8EKWfvnhQxJpd12e3S7cmtqJ3yu+vs5i8F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(316002)(52116002)(8936002)(2906002)(66574015)(5660300002)(186003)(31696002)(86362001)(36756003)(478600001)(53546011)(31686004)(66946007)(66476007)(6486002)(66556008)(16526019)(8676002)(38100700002)(2616005)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1N5SWVpdVdRaDRpYTdYSm5sNTBnODlqamgwcXAyTTN0bGNaZkxtUGxNdWpa?=
 =?utf-8?B?SEpoWXdpRjBjL2lyNjdxcDVjRGlDc3hMZEwxN0N6NDBGSjgvTjM1eHpHY1pK?=
 =?utf-8?B?S1V3R1cvYnJSN3ltdmtEZUwxSTVGRkN1clFUR1ExS2k0ekdIVWM2ZlAxSzgz?=
 =?utf-8?B?cGVWaVV6MkhFMkdaS2hQakZMM1RIZCtJNmNCUVRyVmFBeC9vdjR6U3NtcGJy?=
 =?utf-8?B?R0NseUtZUkZqcHJ1eThiclBHamxJcVRLeFgwRmV0VTE5RnMxU2I0SjNoUUtQ?=
 =?utf-8?B?YUFocVBUbHJZaGJMb0F6VFlsQU9leEN4OGs3bzc2RGlySjk3QmJnc3VDNVhL?=
 =?utf-8?B?QzMwaWhiT3Uwdjh4c0FHS1ZtelY5d1IvdEUvOFVtL1prZWNkclBZOUZCd2dT?=
 =?utf-8?B?bllpckl2MEZzZ0dNMldVMVZaalBBMXhUQmFoNkZtNUlqNFY3UG9mdGZSVW1a?=
 =?utf-8?B?UWE0RjdwL0c4WFRHaFN1OHRSUEd4a25MNU9uOWIwVjdSV093TjdGbjc5VnlQ?=
 =?utf-8?B?b0VYZVRRN2R5MENGTnVRZkh2eDU2OFVwc1ZoRnFOU2VEcU1zSHFYRVB6WXZE?=
 =?utf-8?B?U3BIeGdjV2ludnpuRkFRZWdYN3Z3WXBuMk1rNWhTSnl6a3VZTmQxYlo2S3JF?=
 =?utf-8?B?NmNrNS9QdVAzaGpDV0Y2M0FVYlVxSkREWW13RjFkS0Z4RzB2QUdyR0VibmZr?=
 =?utf-8?B?TStRNThsdHlGZkdXOVYySElGSlR4Wkh6NFc3c3hHZ1dhZFl0TVp5MVQ2WHEr?=
 =?utf-8?B?aHM3alBuRDVibkhGODErTDk3dGtjZ3BXV1pyY09RZFIyNVk0Q2FYVkhWOXBD?=
 =?utf-8?B?Z3puOFd3RiswbWo1Wm1iZ3hpclJFam12OFYzR09xWVdkUWVPU0M2Rm05aU95?=
 =?utf-8?B?QVJNbWoyZWpvSDFWSFdQNVdpUFllZHhZY2tzOVRkRTlCaFFyY05HTzZMNzVm?=
 =?utf-8?B?Q3Y5dk1oWjlzOHEzOTlEV1BBbE0zMm4vUWJwNEUreW1TVUx6Nnl4cm93UGlR?=
 =?utf-8?B?NGxLODFNeStTQ0VYdjhRbkNoSWJqQVJyWnNYZjRIM2lzM3M0dFA4TGw2UXMw?=
 =?utf-8?B?eEVvZ3hTdnkzc0VoRmRqQnowaWF2cCtjcCs3bGljWHltYS91RFJjZUg2Snpm?=
 =?utf-8?B?WlVTaS96N2hTYnBjcU94endwRWZzM3AxalFCbVBRWml1Yy93MkJ1ZERMZTht?=
 =?utf-8?B?cHZWUDJGSDJ1WFd5NVdvUVpRQ3QyTmU4K1VZSEhZQlI1L1RuS1Uyd2g2THpj?=
 =?utf-8?B?M0RQcHIrMytJNnBSVTJqb3M5ck5Icm1lK1lrcVh4MFYzWElPZlVvdm9NeEgr?=
 =?utf-8?B?SjNNaWlRUUExdkZOdCtIbTJLQ0NtUGdMUmYrZ2ZnaVFrbHprYUc1aDUwRmhP?=
 =?utf-8?B?ZWJUOW8yRUlFQWhramdrRVluRDBDbEFnRlV6R2RRWjZ4alNJU1E0VWlqcDJC?=
 =?utf-8?B?THkvTktPek1aNGFuSVRmYjJ1VCtzNGxTeEp2R3JOelZNWmN1RnpvKzZtNDRk?=
 =?utf-8?B?ZHVtakRES3FsVi83NDE3REZTdjBYTC9PQ2EzSHh1Tzc1a01ZK1FGcDZ1V3FP?=
 =?utf-8?B?TXpqVjdXc01lMFE0aDE0RXNMdkxkRjMyeVFCV3VYM2poNzhlM3dQb0JDNXlR?=
 =?utf-8?B?SjdKYnB5MTE2RzdNdDFqNk1xWWtHbk5WQTBQR0c3UXRnTHZJUnplL2ZIb01v?=
 =?utf-8?B?OUZUbmJxT1NPbkdNT0ZVTXQ0b25hOVlxUjQzWGdiUncvWGFlaDlQMllObllR?=
 =?utf-8?B?RTdhVnFXVWkxZXB2Ny8vSGlBd095b3d0WHVtVTFJRjQ5SVlrZnZ1aGdXQUd1?=
 =?utf-8?B?U0tET2lwOEd3TnVLSGZKdUNuVVl5MWJSVGtOOHBkMEtlejQxMTQ2YlhGb2hn?=
 =?utf-8?Q?rpT1u9ZOLclDE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad2de55-d12e-44f6-9869-08d92ff4ffde
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 11:59:16.2064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivCzZI6TThqkKIRrkIVAThVOozc+RYmNkPG8X4YSwk5MwT7Mx8k0H/uS9OiZIeeqekxKy/Q1yxm4LJtLSa8sXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5263
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDYvMTUvMjAyMSAxOjU3IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4KPiBBbSAx
NS4wNi4yMSB1bSAxMzo1MSBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IE1vdmUgc2hhZG93X2xpc3Qg
dG8gc3RydWN0IGFtZGdwdV9ib192bSBhcyBzaGFkb3cgQk9zCj4+IGFyZSBwYXJ0IG9mIFBUL1BE
IEJPcy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29t
Pgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
IHzCoCA1ICsrKy0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYyB8IDE0ICsrKysrKysrLS0tLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9vYmplY3QuaCB8wqAgNiArKy0tLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmPCoMKgwqDCoCB8wqAgMiArLQo+PiDCoCA0IGZpbGVzIGNoYW5nZWQs
IDE0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIAo+PiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+PiBpbmRleCBmMjYzNmY0MTFhMjUuLjNm
NTFiMTQyZmM4MyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYwo+PiBAQCAtNDA2Myw2ICs0MDYzLDcgQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNl
X3JlY292ZXJfdnJhbShzdHJ1Y3QgCj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+IMKgIHsKPj4g
wqDCoMKgwqDCoCBzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSA9IE5VTEwsICpuZXh0ID0gTlVMTDsK
Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvICpzaGFkb3c7Cj4+ICvCoMKgwqAgc3RydWN0
IGFtZGdwdV9ib192bSAqdm1ibzsKPj4gwqDCoMKgwqDCoCBsb25nIHIgPSAxLCB0bW87Cj4+IMKg
IMKgwqDCoMKgwqAgaWYgKGFtZGdwdV9zcmlvdl9ydW50aW1lKGFkZXYpKQo+PiBAQCAtNDA3Miw4
ICs0MDczLDggQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX3JlY292ZXJfdnJhbShzdHJ1Y3Qg
Cj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+IMKgIMKgwqDCoMKgwqAgZGV2X2luZm8oYWRldi0+
ZGV2LCAicmVjb3ZlciB2cmFtIGJvIGZyb20gc2hhZG93IHN0YXJ0XG4iKTsKPj4gwqDCoMKgwqDC
oCBtdXRleF9sb2NrKCZhZGV2LT5zaGFkb3dfbGlzdF9sb2NrKTsKPj4gLcKgwqDCoCBsaXN0X2Zv
cl9lYWNoX2VudHJ5KHNoYWRvdywgJmFkZXYtPnNoYWRvd19saXN0LCBzaGFkb3dfbGlzdCkgewo+
PiAtCj4+ICvCoMKgwqAgbGlzdF9mb3JfZWFjaF9lbnRyeSh2bWJvLCAmYWRldi0+c2hhZG93X2xp
c3QsIHNoYWRvd19saXN0KSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBzaGFkb3cgPSAmdm1iby0+Ym87
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBObyBuZWVkIHRvIHJlY292ZXIgYW4gZXZpY3RlZCBC
TyAqLwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHNoYWRvdy0+dGJvLm1lbS5tZW1fdHlwZSAh
PSBUVE1fUExfVFQgfHwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2hhZG93LT50Ym8u
bWVtLnN0YXJ0ID09IEFNREdQVV9CT19JTlZBTElEX09GRlNFVCB8fAo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIAo+PiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+PiBpbmRleCBlYTU0ZmQ3MzljNDEu
LmVhMzM5ZWFhYzM5OSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X29iamVjdC5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9vYmplY3QuYwo+PiBAQCAtMTAzLDExICsxMDMsMTMgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2Jv
X3ZtX2Rlc3Ryb3koc3RydWN0IAo+PiB0dG1fYnVmZmVyX29iamVjdCAqdGJvKQo+PiDCoCB7Cj4+
IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBhbWRncHVfdHRtX2FkZXYo
dGJvLT5iZGV2KTsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvICpibyA9IHR0bV90b19h
bWRncHVfYm8odGJvKTsKPj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvX3ZtICp2bWJvOwo+PiDC
oCArwqDCoMKgIHZtYm8gPSB0b19hbWRncHVfYm9fdm0oYm8pOwo+PiDCoMKgwqDCoMKgIC8qIGlu
IGNhc2UgYW1kZ3B1X2RldmljZV9yZWNvdmVyX3ZyYW0gZ290IE5VTEwgb2YgYm8tPnBhcmVudCAq
Lwo+PiAtwqDCoMKgIGlmICghbGlzdF9lbXB0eSgmYm8tPnNoYWRvd19saXN0KSkgewo+PiArwqDC
oMKgIGlmICghbGlzdF9lbXB0eSgmdm1iby0+c2hhZG93X2xpc3QpKSB7Cj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBtdXRleF9sb2NrKCZhZGV2LT5zaGFkb3dfbGlzdF9sb2NrKTsKPj4gLcKgwqDCoMKg
wqDCoMKgIGxpc3RfZGVsX2luaXQoJmJvLT5zaGFkb3dfbGlzdCk7Cj4+ICvCoMKgwqDCoMKgwqDC
oCBsaXN0X2RlbF9pbml0KCZ2bWJvLT5zaGFkb3dfbGlzdCk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBtdXRleF91bmxvY2soJmFkZXYtPnNoYWRvd19saXN0X2xvY2spOwo+PiDCoMKgwqDCoMKgIH0K
Pj4gwqAgQEAgLTU4Myw3ICs1ODUsNiBAQCBpbnQgYW1kZ3B1X2JvX2NyZWF0ZShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKPj4gwqDCoMKgwqDCoCBpZiAoYm8gPT0gTlVMTCkKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOwo+PiDCoMKgwqDCoMKgIGRybV9nZW1fcHJpdmF0
ZV9vYmplY3RfaW5pdChhZGV2X3RvX2RybShhZGV2KSwgJmJvLT50Ym8uYmFzZSwgCj4+IHNpemUp
Owo+PiAtwqDCoMKgIElOSVRfTElTVF9IRUFEKCZiby0+c2hhZG93X2xpc3QpOwo+PiDCoMKgwqDC
oMKgIGJvLT52bV9ibyA9IE5VTEw7Cj4+IMKgwqDCoMKgwqAgYm8tPnByZWZlcnJlZF9kb21haW5z
ID0gYnAtPnByZWZlcnJlZF9kb21haW4gPyAKPj4gYnAtPnByZWZlcnJlZF9kb21haW4gOgo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgYnAtPmRvbWFpbjsKPj4gQEAgLTcxMyw2ICs3MTQsNyBAQCBpbnQg
YW1kZ3B1X2JvX2NyZWF0ZV92bShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiByOwo+PiDCoCDCoMKgwqDCoMKgICp2bWJvX3B0ciA9IHRvX2Ft
ZGdwdV9ib192bShib19wdHIpOwo+PiArwqDCoMKgIElOSVRfTElTVF9IRUFEKCYoKnZtYm9fcHRy
KS0+c2hhZG93X2xpc3QpOwo+PiDCoMKgwqDCoMKgIHJldHVybiByOwo+PiDCoCB9Cj4+IMKgIEBA
IC03NTcsMTIgKzc1OSwxMiBAQCBpbnQgYW1kZ3B1X2JvX3ZhbGlkYXRlKHN0cnVjdCBhbWRncHVf
Ym8gKmJvKQo+PiDCoMKgICoKPj4gwqDCoCAqIEluc2VydCBhIEJPIHRvIHRoZSBzaGFkb3cgbGlz
dC4KPj4gwqDCoCAqLwo+PiAtdm9pZCBhbWRncHVfYm9fYWRkX3RvX3NoYWRvd19saXN0KHN0cnVj
dCBhbWRncHVfYm8gKmJvKQo+PiArdm9pZCBhbWRncHVfYm9fYWRkX3RvX3NoYWRvd19saXN0KHN0
cnVjdCBhbWRncHVfYm9fdm0gKnZtYm8pCj4+IMKgIHsKPj4gLcKgwqDCoCBzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiA9IGFtZGdwdV90dG1fYWRldihiby0+dGJvLmJkZXYpOwo+PiArwqDCoMKg
IHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KHZtYm8tPmJvLnRi
by5iZGV2KTsKPj4gwqAgwqDCoMKgwqDCoCBtdXRleF9sb2NrKCZhZGV2LT5zaGFkb3dfbGlzdF9s
b2NrKTsKPj4gLcKgwqDCoCBsaXN0X2FkZF90YWlsKCZiby0+c2hhZG93X2xpc3QsICZhZGV2LT5z
aGFkb3dfbGlzdCk7Cj4+ICvCoMKgwqAgbGlzdF9hZGRfdGFpbCgmdm1iby0+c2hhZG93X2xpc3Qs
ICZhZGV2LT5zaGFkb3dfbGlzdCk7Cj4+IMKgwqDCoMKgwqAgbXV0ZXhfdW5sb2NrKCZhZGV2LT5z
aGFkb3dfbGlzdF9sb2NrKTsKPj4gwqAgfQo+PiDCoCBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+PiBpbmRleCBhOGM3MDI2MzRlMWIuLjE4Y2IyZjI4ZTRk
ZSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVj
dC5oCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+
PiBAQCAtMTA5LDkgKzEwOSw2IEBAIHN0cnVjdCBhbWRncHVfYm8gewo+PiDCoCAjaWZkZWYgQ09O
RklHX01NVV9OT1RJRklFUgo+PiDCoMKgwqDCoMKgIHN0cnVjdCBtbXVfaW50ZXJ2YWxfbm90aWZp
ZXLCoMKgwqAgbm90aWZpZXI7Cj4+IMKgICNlbmRpZgo+PiAtCj4+IC3CoMKgwqAgc3RydWN0IGxp
c3RfaGVhZMKgwqDCoMKgwqDCoMKgIHNoYWRvd19saXN0Owo+PiAtCj4+IMKgwqDCoMKgwqAgc3Ry
dWN0IGtnZF9tZW3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICprZmRfYm87Cj4+
IMKgIH07Cj4+IMKgIEBAIC0xMjcsNiArMTI0LDcgQEAgc3RydWN0IGFtZGdwdV9ib191c2VyIHsK
Pj4gwqAgc3RydWN0IGFtZGdwdV9ib192bSB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9i
b8KgwqDCoMKgwqDCoMKgIGJvOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm/CoMKgwqDC
oMKgwqDCoCAqc2hhZG93Owo+PiArwqDCoMKgIHN0cnVjdCBsaXN0X2hlYWTCoMKgwqDCoMKgwqDC
oCBzaGFkb3dfbGlzdDsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3ZtX2JvX2Jhc2XCoMKg
wqDCoMKgwqDCoCBlbnRyaWVzW107Cj4+IMKgIH07Cj4+IMKgIEBAIC0zMzMsNyArMzMxLDcgQEAg
dTY0IGFtZGdwdV9ib19ncHVfb2Zmc2V0X25vX2NoZWNrKHN0cnVjdCAKPj4gYW1kZ3B1X2JvICpi
byk7Cj4+IMKgIGludCBhbWRncHVfYm9fdmFsaWRhdGUoc3RydWN0IGFtZGdwdV9ibyAqYm8pOwo+
PiDCoCB2b2lkIGFtZGdwdV9ib19nZXRfbWVtb3J5KHN0cnVjdCBhbWRncHVfYm8gKmJvLCB1aW50
NjRfdCAqdnJhbV9tZW0sCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWlu
dDY0X3QgKmd0dF9tZW0sIHVpbnQ2NF90ICpjcHVfbWVtKTsKPj4gLXZvaWQgYW1kZ3B1X2JvX2Fk
ZF90b19zaGFkb3dfbGlzdChzdHJ1Y3QgYW1kZ3B1X2JvICpibyk7Cj4+ICt2b2lkIGFtZGdwdV9i
b19hZGRfdG9fc2hhZG93X2xpc3Qoc3RydWN0IGFtZGdwdV9ib192bSAqdm1ibyk7Cj4+IMKgIGlu
dCBhbWRncHVfYm9fcmVzdG9yZV9zaGFkb3coc3RydWN0IGFtZGdwdV9ibyAqc2hhZG93LAo+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRtYV9mZW5jZSAqKmZl
bmNlKTsKPj4gwqAgdWludDMyX3QgYW1kZ3B1X2JvX2dldF9wcmVmZXJyZWRfcGluX2RvbWFpbihz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAKPj4gKmFkZXYsCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYwo+PiBpbmRleCA0YzRjNTY1ODE3ODAuLjgxMmMyMjU1MzhhNyAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gQEAgLTkzNiw3ICs5
MzYsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9wdF9jcmVhdGUoc3RydWN0IAo+PiBhbWRncHVf
ZGV2aWNlICphZGV2LAo+PiDCoMKgwqDCoMKgIH0KPj4gwqAgwqDCoMKgwqDCoCAoKnZtYm8pLT5z
aGFkb3ctPnBhcmVudCA9IGFtZGdwdV9ib19yZWYoYm8pOwo+PiAtwqDCoMKgIGFtZGdwdV9ib19h
ZGRfdG9fc2hhZG93X2xpc3QoKCp2bWJvKS0+c2hhZG93KTsKPj4gK8KgwqDCoCBhbWRncHVfYm9f
YWRkX3RvX3NoYWRvd19saXN0KCgqdm1ibykpOwo+Cj4gWW91IGNhbiBkcm9wIHRoZSBleHRyYSAo
KSBwYWlyIGhlcmUuCj4KPiBBcGFydCBmcm9tIHRoYXQgdGhlIHNlcmllcyBpcyBSZXZpZXdlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyAKPiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKClRoYW5r
cywgQ2hyaXN0aWFuLiBJIHdpbGwgZHJvcCB0aG9zZSBicmFjZXMgYW5kIHN1Ym1pdC4KCgpOaXJt
b3kKCj4KPiBUaGFua3MsCj4gQ2hyaXN0aWFuLgo+Cj4+IMKgIMKgwqDCoMKgwqAgcmV0dXJuIDA7
Cj4+IMKgIH0KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
