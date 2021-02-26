Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23620C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 16:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A890064EF0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 16:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A890064EF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 301F86E408;
	Fri, 26 Feb 2021 16:15:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E93C6E408
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 16:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn132HGTjTMWvKYAXV81oxtdIw0fXZdtvzKFmSXCtEbtWWIATCwWDnbcE7E48DBE+hiLyj1TSF1uU4dgIskul87wXUE5jgHc2oVj1CumDuQzJPIAh1oCFuE3EE5V/Jhn+w4rAak+cOFq6w1PaDkI3F4zSXD0PY81Fh2yJofGfdLa3KAI3JzkEZ3+bt+T7aQBg3TYf7krjsb4+spd6hKvqHe+LN27eSuj0OL6Vc0FOvEiLqEOXOHNbKwdaOK+VYsi6pC5pDJBKOfa3boA0GcLmgkqoSRHEikRSlOCqa87kwEKwfzw8s9mRYk9L/5l53weelrN14sj0HIX1Vq6zezfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNzVxsbgI4Es3ygwBMWUjK+dN79o+zRwFtqEe7op6zg=;
 b=EBA/XP2jAbu5xFTm3yzMzq/BVohYXbNBWyuv5w09pz+MMxFti0C8r9TC7hHgHeb8RFSAR+r7g1tAwkSgem5uGMz0Qbeco6UkWX5AHvd+P81nzatVGWCJvZFnkSZa3JXra+RIjy94TD03OAhUyXC9bmBSjKjioOlZsoK4zbrP+7LS+aDNTy5+2Plz2GxJ8FqgFrP7Xvi1CTdCeN1vVvYeiV3TjMKbFkVZRdfniKzVXbOMeNqQgfTmHVjhYHVDXhoLmQY1lUsdeLdhlKUAH6YY2ER6FI4Hxg52FMG9NeNZGszYUOm6AgwDkuqKmHBD2Te0Lor/LKcR/c5TOzn5HLcZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNzVxsbgI4Es3ygwBMWUjK+dN79o+zRwFtqEe7op6zg=;
 b=hNoDhf5vUGfmzYB+y0D1SqLL/YW5oIlGH0O9weby9jocO/OqXDfCf7im5GgNPdRyouXBsmbnPK/TAoR4f+HnfsttdZx/e/VWHj7s8c4Ro49zW2vFx1tUh4YQgknyC5W10OBze7v/iY9SxplsOj+ynquK7qdtmL0F2oCLQa8gHLI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Fri, 26 Feb
 2021 16:15:47 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::b877:1da1:c4d4:6235]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::b877:1da1:c4d4:6235%6]) with mapi id 15.20.3868.034; Fri, 26 Feb 2021
 16:15:47 +0000
Subject: Re: [bug] tab crash on media playback
To: Cory Bolar <cory.bolar@gmail.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <e281729c-d632-1cc2-a1c7-79b4d1cbdc66@gmail.com>
 <f4b795f8-9f79-a946-49dc-0aea27766bf6@amd.com>
 <b091a944-a002-9f6b-c347-1314a0f64385@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <59967fb7-cf91-d6c9-f431-9b6a60a85c05@amd.com>
Date: Fri, 26 Feb 2021 17:15:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <b091a944-a002-9f6b-c347-1314a0f64385@gmail.com>
Content-Language: en-US
X-Originating-IP: [93.229.45.176]
X-ClientProxiedBy: AM0PR03CA0025.eurprd03.prod.outlook.com
 (2603:10a6:208:14::38) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.45.176) by
 AM0PR03CA0025.eurprd03.prod.outlook.com (2603:10a6:208:14::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 16:15:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92c2320c-530e-446d-d650-08d8da71c637
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3356CA2A07454059833761B78B9D9@DM6PR12MB3356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLbZrGvV3VXFtILqD1swiYVEPzCGHiOVNkg6mT8q+9iowFFKE3ynTnId3WCggp0rrcyEb0WpwLL/ikyVm/E06M7u1nyvxqNMLmz8qC8lcvyj7hNJV+/jLt3j9LYosi2Ur5C7lZv5G9xIVNlsvitVQ9tKWSAJ2P8h7n8kh8oYCJ6HJqzBhQ2ByYJ2Itk4dmoMq3TeBUvwpobdagjkOW2h/VgeTBOhFusN07wTNUJMBFHzf+w2feSex1AP8gaAon+QQDWEypEUiO+mKGDYTFJpO+iZokb4qhJYzfbyRqLKbnqV3LVUyYGkB9/PuKZkvKWYISEs7UpUKtbndrVurmOcNhUrkotQbdUlGAZtW9BWO0zaX9tEDR+OMpSobXyyZk07mmQkSZsNZRtUyAMxHlDTcWf4PXZDQboLtHZ+P3tVFRIIm08P+2hijUYhqNpTikzbC7PglGQ+3egz17iqmPYXgFPb2uOY1ag3lF2C5xKOcrbFThFfxu5BWJybyXNJRF+nafVwe4F0vRyQzLWg94mGX7HgjIv1hCQ4mzxUMbTXRAC7wS9U0zdI/7YQ5bySwcSuhrDdI105XA4XHPABy+3lW/QbrKpb0Sj/2RFaABgI2EvnxrOXUBZNCkXrx31hetPUQuJdhXHQ3+titk5qHp1bEEdt+tPye4jWbliGu+YhjlgG5rX9KsoK3euEJLvglNB0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(66556008)(66476007)(6666004)(6636002)(5660300002)(966005)(31696002)(478600001)(186003)(53546011)(16526019)(316002)(16576012)(45080400002)(4744005)(2906002)(110136005)(36756003)(8936002)(8676002)(31686004)(26005)(2616005)(66946007)(6486002)(956004)(52116002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eXFIcHRGaE8xamtUWTcyT3ZCNWxlbG9xSEJRYXpQd2R3Z3FwZndKZEtOVXAw?=
 =?utf-8?B?aWVsb0NTR05BM0wxaTFRSUpidDdjbWRmcGV6YWNHM1c3ZWV3elJjdGNEZWFO?=
 =?utf-8?B?QUNadC9ocnJ2ZTBxRXMwZ3ZoNlR3UGVzMWcwaGxJK1BUb1FlMElvNHBUMkRj?=
 =?utf-8?B?Y292UDR1aHlNQjZTVlhBN3pac2V0YlZLbGJETzVYYlh1c2xQUUZpZm1PQXlO?=
 =?utf-8?B?V2JpSXlLdWlLcjR5a2U1UkFnTFpYbGJyY0ZSYjl1cURJYk5iRGFwdnRQbW1E?=
 =?utf-8?B?eGpSZU5vYndUMEpZLzl1SHB6TkFCRlNKTys1ZmwvMjRUNnhRNjh4Q2VadEV1?=
 =?utf-8?B?c2o0M2o3bmRkbWxLSWViQU14ZU9yR0ZCR29vT0RScHlwYXQ4eGdWaHc3M2Nv?=
 =?utf-8?B?SWdZa0FNN0F1bWxUeTVVNy9CTnc3TEVQem51SXN5azl2dE1wN1BtTlRrYUVm?=
 =?utf-8?B?aEMySXkzR2l0UXlFMityNERXZEtpVSthbW9lMU1BejRLUjF0SzY4QXNIWjR3?=
 =?utf-8?B?L1I4NURPVlNtREZDNlBPZEZaOVZDVzRPK0JiTEEwUllWOStUMEhJZmwxZFd4?=
 =?utf-8?B?Y00wUmlkZUdXU1ZRbXczR3JhYm9SVmtxdm1ZWjYvYUU3WENrcDFncmU5Yk0v?=
 =?utf-8?B?c2JYWFpFQ0Jzd3RYOFh1cW82bFZUUm4rSGNrb05QUllVRWFORmkrejk3R3dL?=
 =?utf-8?B?ZmpOL242WlUvNFE2UHU1U24vOUZBQ3lEc1RkRHlmT2NvQUFxQlFneVpvVkh2?=
 =?utf-8?B?ZkNRNDNXNXFLbjcyQStLTUtacmpQTGhXSGoyZlk5ZGpZUnhLb1BFNnVyV2hT?=
 =?utf-8?B?VFdvQk5xOUdLMDcwRHY0MXRsZno0aTJSSWhvbDNlMmhQU1FyeG5Oc0Z6U1JY?=
 =?utf-8?B?K1plZXlrSi9FNU5xdzRRc0pKbWZ2aUxpbEQxNlVYTm5qRUxlWW01QUI2bzNi?=
 =?utf-8?B?aUI0Nk4zdkxMWmZLQ0hpVFJqdkZta09lMlFsU0M5V1FyL0xKN1MzMjFHTFBw?=
 =?utf-8?B?cXNLNkJTbEVMZE5zZzI0RzBaR0RUZjFPdVc2dFpGU2RkZDZyTE51UXhhQkth?=
 =?utf-8?B?RTVUdFZRcGtiVU8rcDI3aUFxUy9jSTVrS2lRQzJDM0F5M0tia3ZZR0NrYXUy?=
 =?utf-8?B?VExPSlVvMDgzUWJBVE5YVXlmQkh0WTBsYVViWkFjcjFCdjZFSnBVS3h6K2Vt?=
 =?utf-8?B?eE4zRUpMcHgwNm1TVUVTV3BZdDVBNnl4K2ZydzVEN3ZYQ0JWQU1XZzhDR2dQ?=
 =?utf-8?B?UGljNFhzYTdZL0RTTUNhVDRhU3FtUlFwYjVGaHdxQVFaT0d4YTZLSElnTnJk?=
 =?utf-8?B?UXBBblIzU3VCUlM5Um9BK1RKeFQxS0N3dVJ5eTVZcWhBK1h0d0hrZm5jcjdt?=
 =?utf-8?B?R05uWk90cG52WVlBdjFQUmphWDZPbDNFTC9nMFhSUTBuWXNLenRaQ3h3QXo0?=
 =?utf-8?B?SitvY2NsSWxHSkw3d2F4RGNzUzZ6MlpKS2FLeE9qY2lXaklUU3MvcnFrL3Vm?=
 =?utf-8?B?Vng4VTRuOFZVQk83dUZQNHZwOHlQdWhsMnY1STVweUJCUUVwWGM1Z255MHIy?=
 =?utf-8?B?azh0OTY3R0JUcWY1V0JOUjQ3M1hlYjhmTjdUMnZ4NWFXLzE0dEh4SndKVlR4?=
 =?utf-8?B?MjV4TlJTWlAwM0hxUEV4RDR5TThHd2w3WE1NT1JwR3VyZG5GQTJzeFpNVlA0?=
 =?utf-8?B?Wk83RXNIeEdDSHYyTHVYWlJTN3hrUmlwbEhTNGdUU2ZxU3FOWEV6NzVWbTVV?=
 =?utf-8?Q?IVQRTKCPqyzcyK2J3yN5sQj7hS+pT9p9gjKBqGb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c2320c-530e-446d-d650-08d8da71c637
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 16:15:46.9320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AT1PQpOPGiY+8BH3Lve7gZmqGW9a4ouJMiHjaj/N7zXPsPc4RM8hQK82WJVnxz5sJ6+zzNx/McjKrAwQ2EVcEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3356
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

SGkgQ29yeSwKCgpPbiAyLzI2LzIxIDM6MDQgUE0sIENvcnkgQm9sYXIgd3JvdGU6Cj4gT24gMi8y
Ni8yMSA0OjU5IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBDYW4gSSBzZW5kIHlvdSBh
IGRlYnVnZ2luZyBwYXRjaCB3aGljaCBwcmludHMgYSBmZXcgbGluZXMgaW50byBkbWVzZyAKPj4g
d2hlbiBwcm9ibGVtcyBoYXBwZW4/Cj4KPiBJIHdvdWxkIGJlIGhhcHB5IHRvIGFwcGx5IGFuZCB0
ZXN0IGEgZGVidWcgcGF0Y2guCgpQbGVhc2UgdHJ5IHRoaXNbMV0gZGVidWcgcGF0Y2ggYW5kIGxl
dCB1cyBrbm93IGlmIHlvdSBzZWUgYW55dGhpbmcgCmludGVyZXN0aW5nIGluIGRtZXNnLgoKClsx
XSAKaHR0cHM6Ly9naXRodWIuY29tL25pcm1veS9saW51eC9jb21taXQvNzJjN2E3ZTE2Mjg0YjMw
OTA1NzUzMjQxYjFlOTAxMTIxODg4MjJjOQoKClJlZ2FyZHMsCgpOaXJtb3kKCj4KPiBUaGFua3Ms
Cj4KPiBDb3J5Cj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5m
byUyRmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q25pcm1veS5kYXMlNDBhbWQuY29tJTdDN2E4
MGNmNjllM2M2NGVlMzM5NTIwOGQ4ZGE2MjQwODElN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5
OTRlMTgzZCU3QzAlN0MwJTdDNjM3NDk5NDYyODIyNTkzNjM5JTdDVW5rbm93biU3Q1RXRnBiR1pz
YjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lM
Q0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPUF3ZkwlMkJHOE5WZW8yJTJCamQwQkh5RWgl
MkZjWXdVQmRmTGJNTzk1N0JjWENuTGslM0QmYW1wO3Jlc2VydmVkPTAgCj4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
