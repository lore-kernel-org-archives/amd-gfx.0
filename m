Return-Path: <SRS0=HC41=MT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47711C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 07:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E096023F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 07:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F2E096023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EDA86E9F9;
	Tue, 27 Jul 2021 07:02:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA02F73292;
 Tue, 27 Jul 2021 07:02:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCYucfdR8hIMxmMe+N0BjglNNqt635ihIBKH4aYHLYLG3OlAcVSp8H20Ieenv9hw6nm9ympuuLHIP6oQmLNnJgaYP+EKAi0hgJBo6C7MGJFpo20iAvLn5w7IdHpiJVvWSU+OHe/Z2rTsFg4uApgZilBmoGH3QQLdcNIe5yqwnddIFTUbFMJ9MvQGGxEDqVhtYzgNbNmwj8QNYka+Fn1B+MuuKBXiWu8xHRqNoR+Qk3DAg4eC+FUi33nTuA2JR3i7gBUrOsC03XuTNQm1L3U9L2mMhHgjC3iZ0fNPZA9VC9w4YOIDAlCVBq0nhwXygblewvF2B3dgJ681Uwu3sANkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4FEo0fdhUnvT9ZRJENPIFsln9khwh64xqXcXadXILw=;
 b=dBajwDmg+RHXQcoT9YFuXiY3MBvAV/1iVNVL9tQCAIzGVUQMlRdvD+NZ0jEiyN4ecf0MtO5XNFfqNq3Rdk1P/n6fNDq4c7oUnL2ih42oh9332NZTJOg8wAAlZh3cOrWlo9V+fv97bYKw516u66u1E6+CgkqgOA2mvLi9bCqqLsJrb2ldCFp96Eomt20Pyf/R1d2BpiwxXzT6KBsdvwMb0Hf+S6w2Smkaia6Av3H5LAputHu0mij0CNyrRDCkYOtpbiQcF3h+cC1xmVfk3LkDAJE9oXbNXzAgO/3hPK/VvHi4W7fK7rXScvTwJQ9YE5Tm2FGFpfFz4OT3CyClfTpixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4FEo0fdhUnvT9ZRJENPIFsln9khwh64xqXcXadXILw=;
 b=xuIB1t7/vtOgOv9YGACgXGbxMKoAgF+PSusQymJJjoQMXuCstgGgsUgzvCUNbblMHWQzMUlrKKrWvDwwD8IkJrBwrq1mu0fyCnBqFd/2/yx0yXRjNbW3fXUFwMtvqg2qXo6KqeL23yVtS74tMTxENUF93wv9iMQApJL0MCT0ZoY=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3837.namprd12.prod.outlook.com (2603:10b6:208:166::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Tue, 27 Jul
 2021 07:02:03 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 07:02:03 +0000
Subject: Re: [PATCH v4 4/4] drm/amd/display: Add DC_FP helper to check FPU
 state
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 sunpeng.li@amd.com, roman.li@amd.com
References: <20210727005248.1827411-1-Rodrigo.Siqueira@amd.com>
 <20210727005248.1827411-5-Rodrigo.Siqueira@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e9ee0520-45a5-e30c-69e5-dd7cabb0ed86@amd.com>
Date: Tue, 27 Jul 2021 09:01:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210727005248.1827411-5-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
X-ClientProxiedBy: PR2P264CA0035.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::23) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ae22:6310:9a31:9877]
 (2a02:908:1252:fb60:ae22:6310:9a31:9877) by
 PR2P264CA0035.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.17 via Frontend Transport; Tue, 27 Jul 2021 07:01:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afaa6d4f-f190-4ab8-7a12-08d950cc6fd0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3837:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB383775A32BFC8F1019847D2983E99@MN2PR12MB3837.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BEnWsSrtlnXS77aQqc/ETG+GslQOKtVS57WscvjtyKR9A9ogs+iaNJePwp27OGSwwOniAiWIpwVzo6yzUeENs/gMqTjNueMbiLnG+voq4N5jEC6/20JHDVWlfDGHmGkhfIWxasnxnmPGDfwpSE39GB/oPAj++bY0VyVcvZP/ZSTDnwp1SSbLMahjrZ3wQ4RwCY64RGk+JJYKamTiRt9fFd5qu/pyE1xAdJ0i5qwqwADTy7Xi0JOzYiF5Rqk17IGfF7mUIA06oH3gOeCfrt5kMYqfQ4oV5c9tN9fswsyWAXl75y7NFP8gN3h4B3/85GUFR0jm5zPgGAPhnB+cp6iWFThh0dAZIMs771EZ9tWQ51RiAVn4rlxAh6bles/OrQwwthQnFqUFQPEYO6GhwBRORX71d2Pb9Qp3k5VqmDYJtbvbVqoVEBUbZzsC9t0PsRiRZYkNwFonj91uXrCkoLJA0qWWNfvrR4XlfjulDUK+FAhqU5udF1yjC8Fu46mGWoSmYhBYNfotRc7JR7Kh5rdSJ4d1iwuc+HltQwEybHkbrzyxTyp1pFexTTI/yeFOyKiXIplTZWhaIMKIBZJqNGy29W8RYEOSo6ay4gD2vrkWSBnMwzHZgfBGDe2cb8oqYXzduldYUIrQ3nw5LV2Ygu8BH4c6TxaFTuHbbK+27UjBd5M3mg3mNOhUwTv7OmcGDkUYHFran3+o6xEuG1xIvIrfeYR6zmwYKiLsJ9FK6dDZgtRur0EShzNK0Par7pEaRFMi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(86362001)(478600001)(2906002)(2616005)(6666004)(8936002)(6636002)(186003)(31686004)(8676002)(54906003)(316002)(66556008)(66946007)(66476007)(66574015)(6486002)(31696002)(4326008)(5660300002)(83380400001)(38100700002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTdUM2dhSms3bXNZNjNKbEhZOEdDNXZNbThyV0JKUElUc3A2amlQWUNqbFR3?=
 =?utf-8?B?cmNZbXgwK29UdldFTUdPV1VRejFMQXgxcFlRNEExcWNHNGZySXQ2cHhrc3Yw?=
 =?utf-8?B?SUxsM2pEbzA1Z3gya05NVEtzU3FIanV6RE1MbnVYQWYxVVZQVUgrejBJb3Rs?=
 =?utf-8?B?SmVwaE1ITVprUFdxSklBZk9Qd3VHZFNDemlaWFdJbmlWbDNIaVJUS2pvNWRu?=
 =?utf-8?B?eGtuWUtoN0dLRXg4eG1BRlM5RnhlMm5oeXhVbkhJZDFmaVZZOUw4UklJRWdH?=
 =?utf-8?B?bHRnWFZNNU80N3pjb1BjOTlZc05VWm5sMEdhZmo3N3U1WmZnb045emI0YVpj?=
 =?utf-8?B?NTIvdE05WUxxZ1QyMzF5QWF2aS9DeGpob2xURk1rVlNFZnJuMWhiQ3VuNUx3?=
 =?utf-8?B?MDQ1R2QzTDBRSjdESm82SWhCT3V3YXlINjZSekV5VEpzaUQ2V3Z6N0xWcXhK?=
 =?utf-8?B?MVhMUktUR1lKVjV4ck5TR09BWWxRbjBlL0JtUkxTRTZaM0FseU43enJuWmF0?=
 =?utf-8?B?dWtsNDF4TVRPWUtJRU5lejV1MzNyM0V6eFpjamNUbHVFNFhyR3NtYkNmSTNo?=
 =?utf-8?B?N0g1aUpnWnpXOGJvalczU3FDYyttV1Bwb0xvOTF5R21kd2RyNGZvQUd3enNZ?=
 =?utf-8?B?MWd5b0JzMGpCWW1seDJQZmhrK0lCTG5jMENyVFZtR3lHSzU4T1BzU0VhWTg3?=
 =?utf-8?B?dkpWS1NEUUVkZFNTNUpuZEZvVGthUXFtTUFzUGNESzN2anlUSG8rZ3NSdWVs?=
 =?utf-8?B?L0FKM3lEMm51VStTbnNXck9FL3N4WWZNdXJ5TWxPckFMNnJMR0llWW1XN3ZI?=
 =?utf-8?B?bkJrS2huWHZjbmhVcmc2RCtkWithSXJia1pqMWhQWW1ham0rUlp1R2dobXdT?=
 =?utf-8?B?bFlNc25abzd0ZVJEK3FKTUh3NVZiZnVFZlZUVWhqR29nN3J5L3VPZ25OdTBk?=
 =?utf-8?B?ODNzeTB3WGdDSnRvQzcvdlRqaGZTclIycU9yVC9leEhvZWYwVmNLQjIwQlND?=
 =?utf-8?B?V1N6b2lIVjV2cmFWMzFGTndOeGR5UUY4RTd4MWYzTzZxMVAwc1B5aFphY2xI?=
 =?utf-8?B?alJSOWtidHZuVGdrem5sdlE1VzE5Y3ZHcnZGVVJTUGtCUzdoNTVIOHF2LzVn?=
 =?utf-8?B?WjZIcHlpazJwZ3JGS00zbDkyV0Z5UXE2ZnZ2aGVhVkRGUytwVHM4OTZzUEdk?=
 =?utf-8?B?c0h2MWptRkJ3d2NHeHJYbnc0eWhyK2ExQ29FamVlcCtQY3RWTFlZYU8yS3dh?=
 =?utf-8?B?eGI5Zk91akV1UWhPVGRYTldBOUdYaGE3WGgvd21MVEZvNUp4bUVXUzlHM1lL?=
 =?utf-8?B?QUFEL1JDSTlFTFNOeVduMWVtajhjeVVuV2tlTG1mOUNSWlIwNTRnMFdkMlVR?=
 =?utf-8?B?NTRDc1pUejdFQWVDZDVGNVJ5WjFGUzdNVUlUNXJwZmdqRm1VWHplS3BENUtJ?=
 =?utf-8?B?YlVNNEs5S1NvM0JndS9nTHgrZ2w0RDhPYW9ycVdCY2F0cDlCdnZ5Wkt6aGN2?=
 =?utf-8?B?MFczTXJCWmJsTkQwNkZWU0hUazU2SjVXSDFRRGZ2dEhaNGhxVUdwYitxSUwv?=
 =?utf-8?B?Yjh6VzV3eWlnT2ZGaWF5dUpFNWhEeVkvVGVpQ296WnpuczFwbXlWZ24rekx5?=
 =?utf-8?B?N2dxR1lSU0FFK0NlcWdjYjQrRzhtTlNhNmtUNUpSSGV1bU5XYW5SK1Z2MnJj?=
 =?utf-8?B?dEg0d0ZtTDN3cTk5QVNkL3hJZzN3L3NndVl3TENnZTljR2FkTTlFcndKcURQ?=
 =?utf-8?B?TmcvOGlTR1poVUFYM0JKMFd3MXpKYkV3ODBLYjZhck1zSDNRWnoySUhGYnJx?=
 =?utf-8?B?Sk1ZSXM5b2MyeXdia3dFUXdGNFo5RWdhVVpueDJwbnd5NkowMjQ3d1BnM2Zo?=
 =?utf-8?Q?iQPQQGECqjESx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afaa6d4f-f190-4ab8-7a12-08d950cc6fd0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 07:02:03.0479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSuGIZbX252S0yCnJwH85uUtNsUt7L/qwHFCnxSe2hi0XkcLKc57sz1SakxoKAOD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3837
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
Cc: Aric Cyr <aric.cyr@amd.com>, kernel test robot <lkp@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Anson Jacob <Anson.Jacob@amd.com>,
 Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jun Lei <jun.lei@amd.com>, Harry Wentland <harry.wentland@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjcuMDcuMjEgdW0gMDI6NTIgc2NocmllYiBSb2RyaWdvIFNpcXVlaXJhOgo+IFRvIGZ1bGx5
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
bmcuCj4KPiBDaGFuZ2VzIGNpbmNlIFYzOgo+IC0gUmViYXNlCj4KPiBDaGFuZ2VzIGNpbmNlIFYy
IChDaHJpc3RpYW4pOgo+IC0gRG8gbm90IHVzZSB0aGlzX2NwdV8qIGJldHdlZW4gZ2V0L3B1dF9j
cHVfcHRyKCkuCj4gLSBJbiB0aGUga2VybmVsIGRvY3VtZW50YXRpb24sIGJldHRlciBkZXNjcmli
ZSByZXN0cmljdGlvbnMuCj4gLSBNYWtlIGRjX2Fzc2VydF9mcF9lbmFibGVkIHRyaWdnZXIgdGhl
IEFTU0VSVCBtZXNzYWdlLgo+Cj4gQ2hhbmdlcyBzaW5jZSBWMToKPiAtIFJlbW92ZSBmcF9lbmFi
bGUgdmFyaWFibGVzCj4gLSBSZW5hbWUgZGNfaXNfZnBfZW5hYmxlZCB0byBkY19hc3NlcnRfZnBf
ZW5hYmxlZAo+IC0gUmVwbGFjZSB3cm9uZyB2YXJpYWJsZSB0eXBlCj4KPiBDYzogSGFycnkgV2Vu
dGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4gQ2M6IEFuc29uIEphY29iIDxBbnNvbi5K
YWNvYkBhbWQuY29tPgo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cj4gQ2M6IEhlcnNlbiBXdSA8aGVyc2VueHMud3VAYW1kLmNvbT4KPiBDYzogQXJpYyBD
eXIgPGFyaWMuY3lyQGFtZC5jb20+Cj4gQ2M6IEp1biBMZWkgPGp1bi5sZWlAYW1kLmNvbT4KPiBD
YzogRG15dHJvIExha3R5dXNoa2luIDxkbXl0cm8ubGFrdHl1c2hraW5AYW1kLmNvbT4KPiBDYzog
UWluZ3FpbmcgWmh1byA8cWluZ3Fpbmcuemh1b0BhbWQuY29tPgo+IFJlcG9ydGVkLWJ5OiBrZXJu
ZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBSb2RyaWdvIFNp
cXVlaXJhIDxSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIC4uLi9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9kY19mcHUuYyAgICB8IDE5ICsrKysrKysrKysrKysrKysr
KysKPiAgIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9kY19mcHUuaCAgICB8ICAx
ICsKPiAgIC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYyB8ICAy
ICsrCj4gICAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMngvZGNuMnguYyAgfCAx
OCArKysrKysrKysrKysrKysrKysKPiAgIDQgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygr
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
ZGNfZnB1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2RjX2ZwdS5j
Cj4gaW5kZXggMzM4MDdkNzQ2ZTc2Li5jOWY0N2QxNjc0NzIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9kY19mcHUuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vZGNfZnB1LmMKPiBAQCAtNDYsNiArNDYsMjUg
QEAKPiAgIAo+ICAgc3RhdGljIERFRklORV9QRVJfQ1BVKGludCwgZnB1X3JlY3Vyc2lvbl9kZXB0
aCk7Cj4gICAKPiArLyoqCj4gKyAqIGRjX2Fzc2VydF9mcF9lbmFibGVkIC0gQ2hlY2sgaWYgRlBV
IHByb3RlY3Rpb24gaXMgZW5hYmxlZAo+ICsgKgo+ICsgKiBUaGlzIGZ1bmN0aW9uIHRlbGxzIGlm
IHRoZSBjb2RlIGlzIGFscmVhZHkgdW5kZXIgRlBVIHByb3RlY3Rpb24gb3Igbm90LiBBCj4gKyAq
IGZ1bmN0aW9uIHRoYXQgd29ya3MgYXMgYW4gQVBJIGZvciBhIHNldCBvZiBGUFUgb3BlcmF0aW9u
cyBjYW4gdXNlIHRoaXMKPiArICogZnVuY3Rpb24gZm9yIGNoZWNraW5nIGlmIHRoZSBjYWxsZXIg
aW52b2tlZCBpdCBhZnRlciBEQ19GUF9TVEFSVCgpLiBGb3IKPiArICogZXhhbXBsZSwgdGFrZSBh
IGxvb2sgYXQgZGNuMnguYyBmaWxlLgo+ICsgKi8KPiAraW5saW5lIHZvaWQgZGNfYXNzZXJ0X2Zw
X2VuYWJsZWQodm9pZCkKPiArewo+ICsJaW50ICpwY3B1LCBkZXB0aCA9IDA7Cj4gKwo+ICsJcGNw
dSA9IGdldF9jcHVfcHRyKCZmcHVfcmVjdXJzaW9uX2RlcHRoKTsKPiArCWRlcHRoID0gKnBjcHU7
Cj4gKwlwdXRfY3B1X3B0cigmZnB1X3JlY3Vyc2lvbl9kZXB0aCk7Cj4gKwo+ICsJQVNTRVJUKGRl
cHRoID4gMSk7Cj4gK30KPiArCj4gICAvKioKPiAgICAqIGRjX2ZwdV9iZWdpbiAtIEVuYWJsZXMg
RlBVIHByb3RlY3Rpb24KPiAgICAqIEBmdW5jdGlvbl9uYW1lOiBBIHN0cmluZyBjb250YWluaW5n
IHRoZSBmdW5jdGlvbiBuYW1lIGZvciBkZWJ1ZyBwdXJwb3Nlcwo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2RjX2ZwdS5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9kY19mcHUuaAo+IGluZGV4IGZiNTQ5ODNjNWM2MC4u
YjgyNzViMzk3OTIwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9h
bWRncHVfZG0vZGNfZnB1LmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2RjX2ZwdS5oCj4gQEAgLTI3LDYgKzI3LDcgQEAKPiAgICNpZm5kZWYgX19EQ19GUFVf
SF9fCj4gICAjZGVmaW5lIF9fRENfRlBVX0hfXwo+ICAgCj4gK3ZvaWQgZGNfYXNzZXJ0X2ZwX2Vu
YWJsZWQodm9pZCk7Cj4gICB2b2lkIGRjX2ZwdV9iZWdpbihjb25zdCBjaGFyICpmdW5jdGlvbl9u
YW1lLCBjb25zdCBpbnQgbGluZSk7Cj4gICB2b2lkIGRjX2ZwdV9lbmQoY29uc3QgY2hhciAqZnVu
Y3Rpb25fbmFtZSwgY29uc3QgaW50IGxpbmUpOwo+ICAgCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMKPiBpbmRleCA5ODhk
N2MwMjE5OWMuLmUzZTAxYjE3YzE2NCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jCj4gQEAgLTIzNTcsNyArMjM1
Nyw5IEBAIGludCBkY24yMF9wb3B1bGF0ZV9kbWxfcGlwZXNfZnJvbV9jb250ZXh0KAo+ICAgCX0K
PiAgIAo+ICAgCS8qIHBvcHVsYXRlIHdyaXRlYmFjayBpbmZvcm1hdGlvbiAqLwo+ICsJRENfRlBf
U1RBUlQoKTsKPiAgIAlkYy0+cmVzX3Bvb2wtPmZ1bmNzLT5wb3B1bGF0ZV9kbWxfd3JpdGViYWNr
X2Zyb21fY29udGV4dChkYywgcmVzX2N0eCwgcGlwZXMpOwo+ICsJRENfRlBfRU5EKCk7Cj4gICAK
PiAgIAlyZXR1cm4gcGlwZV9jbnQ7Cj4gICB9Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMngvZGNuMnguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kbWwvZGNuMngvZGNuMnguYwo+IGluZGV4IDhmMGY2MjIwMzI3ZC4uYzU4NTIy
NDM2MjkxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwv
ZGNuMngvZGNuMnguYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwv
ZGNuMngvZGNuMnguYwo+IEBAIC00Myw2ICs0MywyMiBAQAo+ICAgICogICAgdGhhdCBkZWFscyB3
aXRoIEZQIHJlZ2lzdGVyIGlzIGNvbnRhaW5lZCB3aXRoaW4gdGhpcyBjYWxsLgo+ICAgICogMy4g
QWxsIGZ1bmN0aW9uIHRoYXQgbmVlZHMgdG8gYmUgYWNjZXNzZWQgb3V0c2lkZSB0aGlzIGZpbGUg
cmVxdWlyZXMgYQo+ICAgICogICAgcHVibGljIGludGVyZmFjZSB0aGF0IG5vdCB1c2VzIGFueSBG
UFUgcmVmZXJlbmNlLgo+ICsgKiA0LiBEZXZlbG9wZXJzICoqbXVzdCBub3QqKiB1c2UgRENfRlBf
U1RBUlQvRU5EIGluIHRoaXMgZmlsZSwgYnV0IHRoZXkgbmVlZAo+ICsgKiAgICB0byBlbnN1cmUg
dGhhdCB0aGUgY2FsbGVyIGludm9rZXMgaXQgYmVmb3JlIGFjY2VzcyBhbnkgZnVuY3Rpb24gYXZh
aWxhYmxlCj4gKyAqICAgIGluIHRoaXMgZmlsZS4gRm9yIHRoaXMgcmVhc29uLCBwdWJsaWMgZnVu
Y3Rpb25zIGluIHRoaXMgZmlsZSBtdXN0IGludm9rZQo+ICsgKiAgICBkY19hc3NlcnRfZnBfZW5h
YmxlZCgpOwo+ICsgKgo+ICsgKiBMZXQncyBleHBhbmQgYSBsaXR0bGUgYml0IG1vcmUgdGhlIGlk
ZWEgaW4gdGhlIGNvZGUgcGF0dGVybi4gVG8gZnVsbHkKPiArICogaXNvbGF0ZSBGUFUgb3BlcmF0
aW9ucyBpbiBhIHNpbmdsZSBwbGFjZSwgd2UgbXVzdCBhdm9pZCBzaXR1YXRpb25zIHdoZXJlCj4g
KyAqIGNvbXBpbGVycyBzcGlsbCBGUCB2YWx1ZXMgdG8gcmVnaXN0ZXJzIGR1ZSB0byBGUCBlbmFi
bGUgaW4gYSBzcGVjaWZpYyBDCj4gKyAqIGZpbGUuIE5vdGUgdGhhdCBldmVuIGlmIHdlIGlzb2xh
dGUgYWxsIEZQVSBmdW5jdGlvbnMgaW4gYSBzaW5nbGUgZmlsZSBhbmQKPiArICogY2FsbCBpdHMg
aW50ZXJmYWNlIGZyb20gb3RoZXIgZmlsZXMsIHRoZSBjb21waWxlciBtaWdodCBlbmFibGUgdGhl
IHVzZSBvZgo+ICsgKiBGUFUgYmVmb3JlIHdlIGNhbGwgRENfRlBfU1RBUlQuIE5ldmVydGhlbGVz
cywgaXQgaXMgdGhlIHByb2dyYW1tZXIncwo+ICsgKiByZXNwb25zaWJpbGl0eSB0byBpbnZva2Ug
RENfRlBfU1RBUlQvRU5EIGluIHRoZSBjb3JyZWN0IHBsYWNlLiBUbyBoaWdobGlnaHQKPiArICog
c2l0dWF0aW9ucyB3aGVyZSBkZXZlbG9wZXJzIGZvcmdvdCB0byB1c2UgdGhlIEZQIHByb3RlY3Rp
b24gYmVmb3JlIGNhbGxpbmcKPiArICogdGhlIERDIEZQVSBpbnRlcmZhY2UgZnVuY3Rpb25zLCB3
ZSBpbnRyb2R1Y2UgYSBoZWxwZXIgdGhhdCBjaGVja3MgaWYgdGhlCj4gKyAqIGZ1bmN0aW9uIGlz
IGludm9rZWQgdW5kZXIgRlAgcHJvdGVjdGlvbi4gSWYgbm90LCBpdCB3aWxsIHRyaWdnZXIgYSBr
ZXJuZWwKPiArICogd2FybmluZy4KPiAgICAqLwo+ICAgCj4gICB2b2lkIGRjbjIwX3BvcHVsYXRl
X2RtbF93cml0ZWJhY2tfZnJvbV9jb250ZXh0KHN0cnVjdCBkYyAqZGMsCj4gQEAgLTUxLDYgKzY3
LDggQEAgdm9pZCBkY24yMF9wb3B1bGF0ZV9kbWxfd3JpdGViYWNrX2Zyb21fY29udGV4dChzdHJ1
Y3QgZGMgKmRjLAo+ICAgewo+ICAgCWludCBwaXBlX2NudCwgaTsKPiAgIAo+ICsJZGNfYXNzZXJ0
X2ZwX2VuYWJsZWQoKTsKPiArCj4gICAJZm9yIChpID0gMCwgcGlwZV9jbnQgPSAwOyBpIDwgZGMt
PnJlc19wb29sLT5waXBlX2NvdW50OyBpKyspIHsKPiAgIAkJc3RydWN0IGRjX3dyaXRlYmFja19p
bmZvICp3Yl9pbmZvID0gJnJlc19jdHgtPnBpcGVfY3R4W2ldLnN0cmVhbS0+d3JpdGViYWNrX2lu
Zm9bMF07Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
