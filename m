Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3E5C07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 08:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B584611ED
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 08:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B584611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2122989BAF;
	Tue, 20 Jul 2021 08:13:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21DE689BAF;
 Tue, 20 Jul 2021 08:13:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz+cTFL0rkt3tyIqpJtKFEmjNmHJujAesALTEJLRZswXU6ILwscIA5vnK1Z5zgrhiMWGCa7tJDJSBf8JBCxAYel0HdKQx2WjXLDDDkHJdNENA1WU2E2Q0Pb0fM8j3T0w7SyU0YhIp8jViNFpRawffc14Cr+yYXXO0MMllEYE2lJICWreH18sxuLVbFxNpZpvS5mADLMsTPBK63viHk4wk1dQfoPZYA2Y0P/YADcTplgXSGacNJsHHUoXEqRXV8+UOETtpmptduRpA0D2LipTbBc1KMGZCZSbgUdd1/iX5x2SEDmLCpFPXFSasazX86AFxzUXA+BjhDrsrpFTLC5RVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjbyyHngaLLCOHXdJuN4z2pSOvvnta3+Nj6r4/swzuA=;
 b=g+P5NBLyOiqLWVOsaXVOmgaf53xnQt+jaDMrkSc/l+dE7S9Zg8e9joFB9ap+BsaOgFz2lAFxJrqVznVssnKXGX5GGQ7wPbyFYU1i0iRNt3R/QU4UiouHtwvmJ2uyevoCGGf7xQsokJhwgD2IpjzOsfo8B59StGfxKCkeKvwrK+wsttYyFExH0+XKIZw9e3Gu0W1Bfb+W/ON9+pHQK9LCRjnn0A4NHKxdILFEm4cJW6F3EbhWSpKP4RvilPvNpgR4cCOCUOCs+f+IYF1L5RGKaoUoLc7LFlkgxlRwE6JAWtxmbut3JnQWmrbgsrmMF2ZXxXYwjOhuD9SYRKFdU/Pkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjbyyHngaLLCOHXdJuN4z2pSOvvnta3+Nj6r4/swzuA=;
 b=x8YcNHewCUWDbB0KO0scuBctghP4HIsgkVJ6RwPb5RUHRFpOFUio7XIgYF3jv5yzFhOp+OBNnkNLBypmHVXumMQt+uM8H7i2M+UX1GqBUr9RWTKaQSeQzP6Wu8JS+2KEaiuVqWCPTzrQXTZVoRCwO6jL5pYQ0B1QH5GSjIRjcts=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4000.namprd12.prod.outlook.com (2603:10b6:208:16b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 08:13:49 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 08:13:49 +0000
Subject: Re: [PATCH v3 4/4] drm/amd/display: Add DC_FP helper to check FPU
 state
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Daniel Vetter <daniel@ffwll.ch>,
 roman.li@amd.com, sunpeng.li@amd.com
References: <20210720004914.3060879-1-Rodrigo.Siqueira@amd.com>
 <20210720004914.3060879-5-Rodrigo.Siqueira@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f3876ee5-7fd3-7690-aa40-348e57fa369d@amd.com>
Date: Tue, 20 Jul 2021 10:13:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210720004914.3060879-5-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
X-ClientProxiedBy: PR3P251CA0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:b5::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:8651:5b5e:8648:2fd0]
 (2a02:908:1252:fb60:8651:5b5e:8648:2fd0) by
 PR3P251CA0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:b5::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:13:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43f268bb-0962-49f2-79c6-08d94b564d9a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB400049B06C0F3743C1E2CF0B83E29@MN2PR12MB4000.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rOyweliqYPTH6+yo0XTlhmophhhhrA2H6pISspyDLZYCVeR0WU9w8GNL9mNSLZK3WNp3jfnmEJBq0Qx27aHShFESVFynao6Z4hF4d6HFYevq0wOMLi+mSBPCVFOe8LxYvUqZI0P1UMMc1bNVgkJp3l2kSdyEwQzJbp+14ZXVCMbgmknLNS3gWckAlEigq2S0jhLHiKhpkoQatiT+/ZoVbud8KndPUT+28egBmyQrIlvnIdmIPV1f7uRKDbMb5vVJnOWHDMRMwPpX+EdrGNfIfp1Bn6ZSep3KFO75ZBkoOyfTUMiNWRdNLR0PmrqIjaTwucdVvtDm8btUfSc6QzMV0+To2X3LPfzLVFEUvYYXlwOF95UKkvQMamiCjQ1omY9dazh8RbUgqyg37ALLMnBf++XGmkyZhKs2jrJOL9o1QT2ZO+C0hrMPWtMb5vImQh05shorNdS13feogiWbicgaRJVT0cafnOsUuUjuQrYOF5Dbd8YFVLQvxSOyWfC8HY6NRIBjIDSu5ouaBxuo25tq2x+dumxSyFMy1dSCRciG5ENrca8OMg9aK6/LsjDg9RGH9LLONWdOPPJ7us7iRwTFAWhmPXIWPhG3WoEJriokRtzC+TxDqlCJg7xW02M6OGS7GdY11FKQ0FG8HVIrnyFKtIvLJsxn8Yx/0HX95fZDUWyqdb68G+Q0Oc70oYUWQwavmVrc9MFK6lR8m46kbOawJ3sYMNBw2WgRZ/M7iAJTHimbY3KPI9y9BVzehIAA8vx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(6486002)(8676002)(6666004)(54906003)(508600001)(66574015)(6636002)(186003)(110136005)(66476007)(4326008)(316002)(66556008)(8936002)(38100700002)(83380400001)(5660300002)(36756003)(31696002)(2616005)(31686004)(2906002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0IxbllEYmNLUFdnTmFROU41ZktWblNaUk1ldW9IM25KNDR0TjQzUlUyQkpG?=
 =?utf-8?B?cjNTeTNvTDBndmh5TUplajgyRlQ4YzgxU1pLTmpxc3RQUi9FS1BQOG9LN1k0?=
 =?utf-8?B?cjcyeDVDMGpLMlRNd2pjOUEzdzV5bHFzNTNSZnJWUHoyUVptWWcxNlhyZjhQ?=
 =?utf-8?B?YlZBM1pwR285NUk1MENsNXF0TWZBMGNRMkR5YjRCYUlWajRoc2s3VjJuUkhq?=
 =?utf-8?B?bTJVb25qTjdGa3hOV3RMcGV5ZjkweU9ORy9hSFo5TURpM0dvL3ZCRW1qVjNI?=
 =?utf-8?B?S3VYd295RVBWOU05U21QZmpOSVVRU0NuNTNrK2VuaVV3NWhXQXdaU09wMUVv?=
 =?utf-8?B?b0pOUkdidnk2Q1gyWFRhSVVpU1h3dXhMUjdvRENBME1JeW1oTE5xNWcrY1dM?=
 =?utf-8?B?VHFZSmsxbmd0bVlIRlM3ZzJNWXZKcEFJLzhiYUVmNHJYRVZmN3pmOU1YV0tx?=
 =?utf-8?B?UmZnOWNVYzhxc3VpWGlmNWM2STNJYXdlbEpvbmVQcXRheU5hNzU3Z0l6L0JN?=
 =?utf-8?B?T3RKWmtadEF2WTZmcG1odFRnc25ydzNudGNmSlU5YVhSdSt0SXRqeHIzMVR6?=
 =?utf-8?B?K3BNMGE2bnpweXJEYU44VDBwSG9EdkNsUW13bGszVEpPTkw3cHBHOGFtR1hi?=
 =?utf-8?B?U1BLaGFxT2lkR0ZLblJaNGZndk9zT0h2YXZCcjB0ZWJLTmM5TmpWTHZ0UURp?=
 =?utf-8?B?Y09VT0huWFFTWmNHTytSQjZVbXNKNDdMdEdaZll3UVlLUTJyajFLU2lQbFpw?=
 =?utf-8?B?UmF3aGRXNUt3QnpTZ0sxay9kc1BPaTladGNFdXQwZ3NiTHRlNTYyckU1cWox?=
 =?utf-8?B?U3JiQlNkWjJ1Umd5cy9vMzI4SlZPTGR1WXVaelNlRlNyUjd2QitUOUI1RHhz?=
 =?utf-8?B?bzh4NDB5cDhFcE1oemFXaVFweVpBRGtMN2syT0pjOWdlVlEzdDFWM2tXQlhM?=
 =?utf-8?B?WmwxMVJYY2s1SDJLNWpQdzFoZkRUQ2M3L2RRN0s3T1ZaQ0pLa1JYMENYRk05?=
 =?utf-8?B?Sm5mblZYMmNtcDdlRzhlZjhBWHVSUFphdUZmR1lQS2hDK08rSUFVajFBemcw?=
 =?utf-8?B?MkwrWmc0K1REempQMFp2OTFRdmgwK2dySU1PNzk2MHRFOGZkZlRHdGFldTgv?=
 =?utf-8?B?N2lVTklrMklZL3RZZDNkUjN1T0lqWkJ5TlBJMHZwdW40Z1prdzlOZTRLL0wy?=
 =?utf-8?B?dmtnR2VvUkx2aFg2amRwSVhPR3VKT1Zaa094bHh0cHBuNllWNTdYSVE4OUR6?=
 =?utf-8?B?NW9ocjA5d0tVWDgxeGJPdEJoZS9lVUZTTXRkTnJ0Q0c4RU1SNUFTdGxpSEhj?=
 =?utf-8?B?dmRudis0SFJzcmF5SXdPQmhxdWp5T00ybmcvbG0zZWI4NjcwaCtHVE1sL1Ez?=
 =?utf-8?B?SmwvWHFYUFN3S1ZSRXFyT0RSbVh6dVBsZFEvQnRoRnFpY0tFU21tUjJ5SVVa?=
 =?utf-8?B?WEhDTUs5VDhkUytXVzMyS01NL1JLZ3lTd2JWZ0dyajBibjl3ZlBIeGxRL3Zp?=
 =?utf-8?B?LzI2Y0V4ZGZQNE94YVZ3RFl5aVpJc3F5RGJPN0ZGQ1psb0swR3UxZS9JaUZB?=
 =?utf-8?B?QmtUYUZtallVQ21WTEZ4TVVnMFFjZUNwZVZpaktxeW15akU3ZmJHdlpXaEtI?=
 =?utf-8?B?eDhXci9jSk9sZ1NCVUx1R3IzMUFOdng0bFZxckx2ZTBxMWR6NEFveTYxSU9y?=
 =?utf-8?B?cXRKaVNGb1dBcnB4MjlZWFIxbS9vK0JzWkRhQzVtN1h2b2F6Z25wUU0rK2pN?=
 =?utf-8?B?RWdUNW90dDI5aDZHK3VwTFJIWlJkNFRpcnRnTGcweERnbVpwUTkvby9ycVRj?=
 =?utf-8?B?Vkw3RklDSlQ2YjRibGlwZWtpV1QvYWdTVDU3V3d3d1FKbStvbVhTKzg3Ymo2?=
 =?utf-8?Q?gDeNpon5zj9y1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f268bb-0962-49f2-79c6-08d94b564d9a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:13:49.2694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4UJ6SEr4T/ug8cB8LFW8VNR6BJNeUs/wUIsUzYw5oVNwQR+lJInf8qgdA3q1aqX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4000
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
Cc: Aric Cyr <aric.cyr@amd.com>, Anson Jacob <Anson.Jacob@amd.com>,
 dri-devel@lists.freedesktop.org, Hersen Wu <hersenxs.wu@amd.com>,
 amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAuMDcuMjEgdW0gMDI6NDkgc2NocmllYiBSb2RyaWdvIFNpcXVlaXJhOgo+IFRvIGZ1bGx5
IGlzb2xhdGUgRlBVIG9wZXJhdGlvbnMgaW4gYSBzaW5nbGUgcGxhY2UsIHdlIG11c3QgYXZvaWQK
PiBzaXR1YXRpb25zIHdoZXJlIGNvbXBpbGVycyBzcGlsbCBGUCB2YWx1ZXMgdG8gcmVnaXN0ZXJz
IGR1ZSB0byBGUCBlbmFibGUKPiBpbiBhIHNwZWNpZmljIEMgZmlsZS4gTm90ZSB0aGF0IGV2ZW4g
aWYgd2UgaXNvbGF0ZSBhbGwgRlBVIGZ1bmN0aW9ucyBpbgo+IGEgc2luZ2xlIGZpbGUgYW5kIGNh
bGwgaXRzIGludGVyZmFjZSBmcm9tIG90aGVyIGZpbGVzLCB0aGUgY29tcGlsZXIKPiBtaWdodCBl
bmFibGUgdGhlIHVzZSBvZiBGUFUgYmVmb3JlIHdlIGNhbGwgRENfRlBfU1RBUlQuIE5ldmVydGhl
bGVzcywgaXQKPiBpcyB0aGUgcHJvZ3JhbW1lcidzIHJlc3BvbnNpYmlsaXR5IHRvIGludm9rZSBE
Q19GUF9TVEFSVC9FTkQgaW4gdGhlCj4gY29ycmVjdCBwbGFjZS4gVG8gaGlnaGxpZ2h0IHNpdHVh
dGlvbnMgd2hlcmUgZGV2ZWxvcGVycyBmb3Jnb3QgdG8gdXNlCj4gdGhlIEZQIHByb3RlY3Rpb24g
YmVmb3JlIGNhbGxpbmcgdGhlIERDIEZQVSBpbnRlcmZhY2UgZnVuY3Rpb25zLCB3ZQo+IGludHJv
ZHVjZSBhIGhlbHBlciB0aGF0IGNoZWNrcyBpZiB0aGUgZnVuY3Rpb24gaXMgaW52b2tlZCB1bmRl
ciBGUAo+IHByb3RlY3Rpb24uIElmIG5vdCwgaXQgd2lsbCB0cmlnZ2VyIGEga2VybmVsIHdhcm5p
bmcuCj4KPiBDaGFuZ2VzIGNpbmNlIFYyIChDaHJpc3RpYW4pOgo+IC0gRG8gbm90IHVzZSB0aGlz
X2NwdV8qIGJldHdlZW4gZ2V0L3B1dF9jcHVfcHRyKCkuCj4gLSBJbiB0aGUga2VybmVsIGRvY3Vt
ZW50YXRpb24sIGJldHRlciBkZXNjcmliZSByZXN0cmljdGlvbnMuCj4gLSBNYWtlIGRjX2Fzc2Vy
dF9mcF9lbmFibGVkIHRyaWdnZXIgdGhlIEFTU0VSVCBtZXNzYWdlLgo+Cj4gQ2hhbmdlcyBzaW5j
ZSBWMToKPiAtIFJlbW92ZSBmcF9lbmFibGUgdmFyaWFibGVzCj4gLSBSZW5hbWUgZGNfaXNfZnBf
ZW5hYmxlZCB0byBkY19hc3NlcnRfZnBfZW5hYmxlZAo+IC0gUmVwbGFjZSB3cm9uZyB2YXJpYWJs
ZSB0eXBlCj4KPiBDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4g
Q2M6IEFuc29uIEphY29iIDxBbnNvbi5KYWNvYkBhbWQuY29tPgo+IENjOiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IEhlcnNlbiBXdSA8aGVyc2VueHMu
d3VAYW1kLmNvbT4KPiBDYzogQXJpYyBDeXIgPGFyaWMuY3lyQGFtZC5jb20+Cj4gU2lnbmVkLW9m
Zi1ieTogUm9kcmlnbyBTaXF1ZWlyYSA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPgoKUmV2aWV3
ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0t
Cj4gICAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vZGNfZnB1LmMgICAgfCAxOSAr
KysrKysrKysrKysrKysrKysrCj4gICAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
ZGNfZnB1LmggICAgfCAgMSArCj4gICAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIw
X3Jlc291cmNlLmMgfCAgMiArKwo+ICAgLi4uL2RybS9hbWQvZGlzcGxheS9kYy9mcHVfb3BlcmF0
aW9ucy9kY24yeC5jIHwgMTggKysrKysrKysrKysrKysrKysrCj4gICA0IGZpbGVzIGNoYW5nZWQs
IDQwIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvYW1kZ3B1X2RtL2RjX2ZwdS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9kY19mcHUuYwo+IGluZGV4IGQwZDNlOGEzNGRiNS4uMTA3ZTFjNTA1NzZlIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vZGNfZnB1LmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2RjX2ZwdS5jCj4g
QEAgLTQxLDYgKzQxLDI1IEBACj4gICAKPiAgIHN0YXRpYyBERUZJTkVfUEVSX0NQVShpbnQsIGZw
dV9yZWN1cnNpb25fZGVwdGgpOwo+ICAgCj4gKy8qKgo+ICsgKiBkY19hc3NlcnRfZnBfZW5hYmxl
ZCAtIENoZWNrIGlmIEZQVSBwcm90ZWN0aW9uIGlzIGVuYWJsZWQKPiArICoKPiArICogVGhpcyBm
dW5jdGlvbiB0ZWxscyBpZiB0aGUgY29kZSBpcyBhbHJlYWR5IHVuZGVyIEZQVSBwcm90ZWN0aW9u
IG9yIG5vdC4gQQo+ICsgKiBmdW5jdGlvbiB0aGF0IHdvcmtzIGFzIGFuIEFQSSBmb3IgYSBzZXQg
b2YgRlBVIG9wZXJhdGlvbnMgY2FuIHVzZSB0aGlzCj4gKyAqIGZ1bmN0aW9uIGZvciBjaGVja2lu
ZyBpZiB0aGUgY2FsbGVyIGludm9rZWQgaXQgYWZ0ZXIgRENfRlBfU1RBUlQoKS4gRm9yCj4gKyAq
IGV4YW1wbGUsIHRha2UgYSBsb29rIGF0IGRjbjJ4LmMgZmlsZS4KPiArICovCj4gK2lubGluZSB2
b2lkIGRjX2Fzc2VydF9mcF9lbmFibGVkKHZvaWQpCj4gK3sKPiArCWludCAqcGNwdSwgZGVwdGgg
PSAwOwo+ICsKPiArCXBjcHUgPSBnZXRfY3B1X3B0cigmZnB1X3JlY3Vyc2lvbl9kZXB0aCk7Cj4g
KwlkZXB0aCA9ICpwY3B1Owo+ICsJcHV0X2NwdV9wdHIoJmZwdV9yZWN1cnNpb25fZGVwdGgpOwo+
ICsKPiArCUFTU0VSVChkZXB0aCA+IDEpOwo+ICt9Cj4gKwo+ICAgLyoqCj4gICAgKiBkY19mcHVf
YmVnaW4gLSBFbmFibGVzIEZQVSBwcm90ZWN0aW9uCj4gICAgKiBAZnVuY3Rpb25fbmFtZTogQSBz
dHJpbmcgY29udGFpbmluZyB0aGUgZnVuY3Rpb24gbmFtZSBmb3IgZGVidWcgcHVycG9zZXMKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9kY19mcHUu
aCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vZGNfZnB1LmgKPiBpbmRl
eCBmYjU0OTgzYzVjNjAuLmI4Mjc1YjM5NzkyMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2RjX2ZwdS5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9kY19mcHUuaAo+IEBAIC0yNyw2ICsyNyw3IEBACj4gICAj
aWZuZGVmIF9fRENfRlBVX0hfXwo+ICAgI2RlZmluZSBfX0RDX0ZQVV9IX18KPiAgIAo+ICt2b2lk
IGRjX2Fzc2VydF9mcF9lbmFibGVkKHZvaWQpOwo+ICAgdm9pZCBkY19mcHVfYmVnaW4oY29uc3Qg
Y2hhciAqZnVuY3Rpb25fbmFtZSwgY29uc3QgaW50IGxpbmUpOwo+ICAgdm9pZCBkY19mcHVfZW5k
KGNvbnN0IGNoYXIgKmZ1bmN0aW9uX25hbWUsIGNvbnN0IGludCBsaW5lKTsKPiAgIAo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3Vy
Y2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJj
ZS5jCj4gaW5kZXggZjk5YjA5NjQzYTUyLi5kMGIzNGM3Zjk5ZGMgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYwo+
IEBAIC0yMzU1LDcgKzIzNTUsOSBAQCBpbnQgZGNuMjBfcG9wdWxhdGVfZG1sX3BpcGVzX2Zyb21f
Y29udGV4dCgKPiAgIAl9Cj4gICAKPiAgIAkvKiBwb3B1bGF0ZSB3cml0ZWJhY2sgaW5mb3JtYXRp
b24gKi8KPiArCURDX0ZQX1NUQVJUKCk7Cj4gICAJZGMtPnJlc19wb29sLT5mdW5jcy0+cG9wdWxh
dGVfZG1sX3dyaXRlYmFja19mcm9tX2NvbnRleHQoZGMsIHJlc19jdHgsIHBpcGVzKTsKPiArCURD
X0ZQX0VORCgpOwo+ICAgCj4gICAJcmV0dXJuIHBpcGVfY250Owo+ICAgfQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZnB1X29wZXJhdGlvbnMvZGNuMnguYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9mcHVfb3BlcmF0aW9ucy9kY24yeC5jCj4g
aW5kZXggOTVhMGI4OTMwMmE5Li4zZWE5MDA5MDI2NGMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2ZwdV9vcGVyYXRpb25zL2RjbjJ4LmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZnB1X29wZXJhdGlvbnMvZGNuMnguYwo+IEBAIC00
Myw2ICs0MywyMiBAQAo+ICAgICogICAgdGhhdCBkZWFscyB3aXRoIEZQIHJlZ2lzdGVyIGlzIGNv
bnRhaW5lZCB3aXRoaW4gdGhpcyBjYWxsLgo+ICAgICogMy4gQWxsIGZ1bmN0aW9uIHRoYXQgbmVl
ZHMgdG8gYmUgYWNjZXNzZWQgb3V0c2lkZSB0aGlzIGZpbGUgcmVxdWlyZXMgYQo+ICAgICogICAg
cHVibGljIGludGVyZmFjZSB0aGF0IG5vdCB1c2VzIGFueSBGUFUgcmVmZXJlbmNlLgo+ICsgKiA0
LiBEZXZlbG9wZXJzICoqbXVzdCBub3QqKiB1c2UgRENfRlBfU1RBUlQvRU5EIGluIHRoaXMgZmls
ZSwgYnV0IHRoZXkgbmVlZAo+ICsgKiAgICB0byBlbnN1cmUgdGhhdCB0aGUgY2FsbGVyIGludm9r
ZXMgaXQgYmVmb3JlIGFjY2VzcyBhbnkgZnVuY3Rpb24gYXZhaWxhYmxlCj4gKyAqICAgIGluIHRo
aXMgZmlsZS4gRm9yIHRoaXMgcmVhc29uLCBwdWJsaWMgZnVuY3Rpb25zIGluIHRoaXMgZmlsZSBt
dXN0IGludm9rZQo+ICsgKiAgICBkY19hc3NlcnRfZnBfZW5hYmxlZCgpOwo+ICsgKgo+ICsgKiBM
ZXQncyBleHBhbmQgYSBsaXR0bGUgYml0IG1vcmUgdGhlIGlkZWEgaW4gdGhlIGNvZGUgcGF0dGVy
bi4gVG8gZnVsbHkKPiArICogaXNvbGF0ZSBGUFUgb3BlcmF0aW9ucyBpbiBhIHNpbmdsZSBwbGFj
ZSwgd2UgbXVzdCBhdm9pZCBzaXR1YXRpb25zIHdoZXJlCj4gKyAqIGNvbXBpbGVycyBzcGlsbCBG
UCB2YWx1ZXMgdG8gcmVnaXN0ZXJzIGR1ZSB0byBGUCBlbmFibGUgaW4gYSBzcGVjaWZpYyBDCj4g
KyAqIGZpbGUuIE5vdGUgdGhhdCBldmVuIGlmIHdlIGlzb2xhdGUgYWxsIEZQVSBmdW5jdGlvbnMg
aW4gYSBzaW5nbGUgZmlsZSBhbmQKPiArICogY2FsbCBpdHMgaW50ZXJmYWNlIGZyb20gb3RoZXIg
ZmlsZXMsIHRoZSBjb21waWxlciBtaWdodCBlbmFibGUgdGhlIHVzZSBvZgo+ICsgKiBGUFUgYmVm
b3JlIHdlIGNhbGwgRENfRlBfU1RBUlQuIE5ldmVydGhlbGVzcywgaXQgaXMgdGhlIHByb2dyYW1t
ZXIncwo+ICsgKiByZXNwb25zaWJpbGl0eSB0byBpbnZva2UgRENfRlBfU1RBUlQvRU5EIGluIHRo
ZSBjb3JyZWN0IHBsYWNlLiBUbyBoaWdobGlnaHQKPiArICogc2l0dWF0aW9ucyB3aGVyZSBkZXZl
bG9wZXJzIGZvcmdvdCB0byB1c2UgdGhlIEZQIHByb3RlY3Rpb24gYmVmb3JlIGNhbGxpbmcKPiAr
ICogdGhlIERDIEZQVSBpbnRlcmZhY2UgZnVuY3Rpb25zLCB3ZSBpbnRyb2R1Y2UgYSBoZWxwZXIg
dGhhdCBjaGVja3MgaWYgdGhlCj4gKyAqIGZ1bmN0aW9uIGlzIGludm9rZWQgdW5kZXIgRlAgcHJv
dGVjdGlvbi4gSWYgbm90LCBpdCB3aWxsIHRyaWdnZXIgYSBrZXJuZWwKPiArICogd2FybmluZy4K
PiAgICAqLwo+ICAgCj4gICB2b2lkIGRjbjIwX3BvcHVsYXRlX2RtbF93cml0ZWJhY2tfZnJvbV9j
b250ZXh0KHN0cnVjdCBkYyAqZGMsCj4gQEAgLTUxLDYgKzY3LDggQEAgdm9pZCBkY24yMF9wb3B1
bGF0ZV9kbWxfd3JpdGViYWNrX2Zyb21fY29udGV4dChzdHJ1Y3QgZGMgKmRjLAo+ICAgewo+ICAg
CWludCBwaXBlX2NudCwgaTsKPiAgIAo+ICsJZGNfYXNzZXJ0X2ZwX2VuYWJsZWQoKTsKPiArCj4g
ICAJZm9yIChpID0gMCwgcGlwZV9jbnQgPSAwOyBpIDwgZGMtPnJlc19wb29sLT5waXBlX2NvdW50
OyBpKyspIHsKPiAgIAkJc3RydWN0IGRjX3dyaXRlYmFja19pbmZvICp3Yl9pbmZvID0gJnJlc19j
dHgtPnBpcGVfY3R4W2ldLnN0cmVhbS0+d3JpdGViYWNrX2luZm9bMF07Cj4gICAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
