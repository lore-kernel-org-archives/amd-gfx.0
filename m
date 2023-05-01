Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3D3C77B73
	for <amd-gfx@archiver.kernel.org>; Mon,  1 May 2023 15:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032EC10E13E;
	Mon,  1 May 2023 15:49:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E5F210E13E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 May 2023 15:49:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtwbc/XZU6s7NjlruJyiUFL5d9alEr191v+IgepJ+r/IDD5EXgtPhhusNYSrN8K5yfUOCnurEwP65ddzhyI6JeEHjwSNZQCeI5zQw6omuKrkCgz6yeMQB0mJCgDUzmJcnsRsJNCJdICVi1Orhmz07YIP7r0QCGm+NwnPFArkOjxyyA4pQsvF75nPNg3FEF2GY/Nb71tNUUwmwJJ1zj9NYYl9DLFFS6SrEInFqlk8T1uDNVn+ProX1xSYCFBBJ8iXeqgnTzzsIEd1F0pr3BOKW+9UIzF9F3CK10txcR4jruH1b0nbPEeaL6WW+27OiyYKlalX07JrcnMX949KjLsmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilST+I2hYH0Fms5wKxW7UhLsuV6+QBtXu+iN3gaR0x8=;
 b=Bp6fNhdsJOGQVImieiRH64GyCV9v/7TClyYUl7ugaOZlHx1Gqy7HeZVFNAgGql46kTm9QY9RQzgumEhaORZKFsSMK9o1ivzQqwJFn04FYOCPlZtg+pLZBmW943/vR+hjHZ/t9UF3yKuXGOme43zqe671GY4fYon8aazqA6MQcOWnHjAhNHt1KtMILQvuPUdCen7evIJHKLe+n0XmwWpAgd0zYDDyWSrHb0Pc+tDUpPolKqkF84nYTZAw5+xummehh7HOwmY5MljizQynpJtZG6bKtW+3y6Um5WZdyWl6b8zIqByZNAd5K/ougb+LwB5kyiGri3x0GLydrDAhaQPF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilST+I2hYH0Fms5wKxW7UhLsuV6+QBtXu+iN3gaR0x8=;
 b=w4aphECxmSJcCnlgVnPQLVeykKFmE7eBAXrm5lQXfmZ5G31ssXc+GXafcLKRQaYXZLBKQgd4A2oEXifqRHiVug/G1EanuTo9UmpuiL21fxd1gIGWyPcEJlKNwaLTqKMZcM1x87ppID9LAtxv2H+KyFtIgRjLwbcSu4UlSGk6v8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 15:49:27 +0000
Received: from CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::c868:bf54:e11a:f1b8]) by CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::c868:bf54:e11a:f1b8%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 15:49:26 +0000
Content-Type: multipart/mixed; boundary="------------DteoM0IwJCMAJ3c0QxuX7A5Z"
Message-ID: <0503f2b2-08e6-df7e-fe79-2300634a605d@amd.com>
Date: Mon, 1 May 2023 11:49:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
From: Thong Thai <thong.thai@amd.com>
Subject: drm/amdgpu/nv: update VCN 3 max HEVC encoding resolution
X-ClientProxiedBy: CH2PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:610:58::14) To CH0PR12MB5089.namprd12.prod.outlook.com
 (2603:10b6:610:bc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5089:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 844e9cc9-6068-4b18-90a4-08db4a5ba49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crzalxHYyo7QxcvqTh9u7LlAmZWEy6r5PMveuXQs3CJ+EbU0qnKFyDHp7wucSK4P1M+eiRCMLGakRbHUzlFYMVAR3vLpWW5AJ2T9R62Mww4xc2FKioq0v1Z2voH3NiZg/efJyfiIGjbFqXFTGRmCZVQcmAqCLH000FArSh3d6/HmB1kCMcYkt7KeEVa9ic5oU95hAdmwMtVKp/0WRIIwevJpUTWh1EdaN60rpBLnSEhQTblvOiUSmys/djoR7AEcAt90gLWL+UQjweRN8O+hMxTwx2GSWQaXdGuzlqE+7hRMjK1lRFxZ+2L9+EX2rETvwC6p4Hfg/FC9HdPLLps6LLF8hBnmzxCi7rxlW/D2NBaWlJW89DhWsws4DpVtucOqkw2ZdBLVPw2nVNhiFDV+s8YxPQcNGZ+0LEOmkh+HWHf57HtIii0PQsFOmpKO9AR7qm/jy+3CkZg3vJGRjl02m1728XgLJDR/DLebQ58Q1f8aM0clExXuMh2nnLbQe9SvicdhsHHFBMu/7Vgizx/8mLAkA7l1bejrPP9SkQxU6UBrqEzl43PyMjIYaR+A1H2PiiMVWuaaLh8CDIp7iZnQ6p1zURoDxQPolWjNnq3V1k/edW8YMFNBM3N8Mgvn9qlfMEPWTLCAAe5QeVtr5vNJMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5089.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(564344004)(86362001)(31686004)(41300700001)(8936002)(8676002)(235185007)(5660300002)(44832011)(15650500001)(83380400001)(38100700002)(31696002)(26005)(6512007)(6506007)(6916009)(66556008)(66946007)(6486002)(2616005)(478600001)(66476007)(316002)(36756003)(2906002)(33964004)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnlhVXNxWWtnRWpieHpnRHllRVZKQnBFNVNwcGlmRmNWS2ZBQUFsV0pXdnV2?=
 =?utf-8?B?Q0ZyZjF5b3FrWkh5RjZvdmRCS2tkUmZZZHpoam1NVERSaDFnRlZ0WmVnanpW?=
 =?utf-8?B?TkNYbFYxeEJmNmdOOUhZdWF6Z1grT3hsYk5PL0VDL3lFV3RsYzFDbFRTTmp3?=
 =?utf-8?B?TG5Cd0ZrWE8wR0JiSGllYUc2c0NuN2dqSzUyN1kwM0RpN3FJYmZNQVE0Zk9a?=
 =?utf-8?B?OXpFY1pvWUdGblhFUEwrL0JKck1BSnNOYkhUeVNLNVFELzgzZSs1TDBXdUwz?=
 =?utf-8?B?V1RwZzhHQ1JkK0dTMkdFOUhJbkVXNkZNdkFPR0NwRnpGZ29zMHVTYmd5M3lX?=
 =?utf-8?B?YVdFRWU3QVJ2UVRxcElONFRWUkNuVm8ycmZOaEJldHB6QkRQalpmNitESXh3?=
 =?utf-8?B?VkpZbjRWZXFmL1h5enBLMFJrVWptQ05ndXFxRnRuR3RYZkRUaVhpclRldHZm?=
 =?utf-8?B?d3lQb3JPSlByL3IyV3BJNUtnV2dqc1JCdCtlQWhjTDJ3cFQzRDBXaHkvdVdu?=
 =?utf-8?B?aXlqck5uRmdBaW5hb1oya0t1dEJGRTlqQXVrWVp4ZzRSUXZrTm5mV2Rsc0p4?=
 =?utf-8?B?TjV4TnJzM2JJOEVGT05tWUtOemVnelBNN1lBeGNrcU9tZzBzcXNJM3A3b1dy?=
 =?utf-8?B?bTh5WnZPSW8vMDdTaEdoWmIwaEhuZE1Id3BkRVFLSE9pbVpDaENLMk5HZXRZ?=
 =?utf-8?B?NGZXeTFWcktNNDdaVWFOZzR4cHp2YWJoMHNpZ1FIZjNtWFhEYk5KeGoyYjRZ?=
 =?utf-8?B?cEhiY1dBYmFMVzhZS1ZxdDlnYUszNWNZeUw0d0pDeWJuTmpaZG1oSzdPOVBy?=
 =?utf-8?B?dHFYUXZTNEFaQXNXQXBHbnFvcHBQMU94eWRGaDNWc3RpL3AwaUpZdW5JVGtC?=
 =?utf-8?B?M0lYR2tWelk0WUNlSXRleTRTMzRubGZxeTFhVys2d3BGR1IwRHhsU2ZlN1ZK?=
 =?utf-8?B?VWF4VVI3U1lOVXRsc2FhK2NjTytYZEVSc0t6VW9EV01adWNtRDZSaHo1NzEy?=
 =?utf-8?B?T0svR0NMbGN4aXFESUNZdGdrd3dnRzc0eHNUKzNWSDBjakc1bW9xbDJVTEpa?=
 =?utf-8?B?Tnk1aVNQNWRGbFZVUG40V1VWRUNQT3ZLOEExU2FpdFBqVmtPVTdzbUtRRmFx?=
 =?utf-8?B?MXd4SmJXVVRYQVdhTnlicnptOXlmU3QxWXlZNXdOL25TSXd5d3hNZkZTQU1X?=
 =?utf-8?B?Z2VuVHJXdmFGRkVyQUpvQVJkQklQSE9tZnN5a0UyWEtoUE94a3p6cU5GTmR3?=
 =?utf-8?B?SjF1amNpODlFV3NDdnRkVGhYK1NkMitlaXZYZSttR3NqbUhvWkZZL1M3ZUFR?=
 =?utf-8?B?QTVpcVdYbmNkRjlFb09RTnhvUXFUTkFSY0U1MEx3KzhPY295eEZNUVlqVG9F?=
 =?utf-8?B?REErYzEwZUc0azhKazFhc3lCK2dkL0ordkdjUzdYMVVhRmNkSHYxRk1VTjZp?=
 =?utf-8?B?Sk1OL0pTVWdBSk5zZFQ0Q2FlaUhSQkh6SVRhTDdCUG5UOHVYRzBGcXdDSkFi?=
 =?utf-8?B?N2lRaDBrcFFmNXlBVzNFK2h2K0lyV0gxUjc1VllnaFBpSkQvbUZBRkorZFRp?=
 =?utf-8?B?YkZDK3ZDL3ZSZU41MlVRbHJOdkFWOFdKbjE3Q1c2RUsyMWpHRi8vR0hmWFpl?=
 =?utf-8?B?a05vOG5QSzNwQ2E1WHNvR2NjQjNLRkNOK0JodFd5T0hOSHZkSXhGQzl4bXlq?=
 =?utf-8?B?VjlBelJEdnJOb3JITjdkQU5ENEJvRjd6eDA0eUl3bkFJTnMzU1NFamJEQktv?=
 =?utf-8?B?cmUrUjhESGVwR3JjZDlVZWNjUXlqUVlHMktPZGhxVThDTUFxU1FWU2IyLzJN?=
 =?utf-8?B?b3ZlSkFmaDJEbWR2WVFkOUdoMkRFRndKL2RvUGoyYkRjYzNTR25SMnd1NmxR?=
 =?utf-8?B?NGNaSWFpOVNkMUtJSmYvbUFMb0xRa0NvVWtlVXpDMmQ4UTdWYmhyeXRua1Bq?=
 =?utf-8?B?VjdrMjhybzNyeTFCcmNhNHVUdXVKRFlIUStaUHF2VCtndUxxV1B5NnY2c0Uv?=
 =?utf-8?B?dmFTQ0FlWi9ZNFd3anl0YlYwYnltR2U0N3dNOGpxVTFqaitKVUZvRFRoMlRj?=
 =?utf-8?B?L1phY2VqU01pUkU0eEE1c2pNZ3d5M3dPMVo3bUpMQmhROVNiamViNWlyQ3hx?=
 =?utf-8?Q?QH6KivYZhwAYnaz03UBiy9Tod?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844e9cc9-6068-4b18-90a4-08db4a5ba49e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5089.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 15:49:26.9355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77AzioehuaOArRKU8EIEcsd5XLV5cvJRAjgubHYf3iciB36UmGfo2unXeyxwdZTdREObEZiQcGF0ypWv0reOAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
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

--------------DteoM0IwJCMAJ3c0QxuX7A5Z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

     drm/amdgpu/nv: update VCN 3 max HEVC encoding resolution

     Update the maximum resolution reported for HEVC encoding on VCN 3
     devices to reflect its 8K encoding capability.

     v2: Also update the max height for H.264 encoding to match spec.
     (Ruijing)

Attached for review.

Thanks,

Thong Thai

--------------DteoM0IwJCMAJ3c0QxuX7A5Z
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-amdgpu-nv-update-VCN-3-max-HEVC-encoding-resolut.patch"
Content-Disposition: attachment;
 filename*0="0001-drm-amdgpu-nv-update-VCN-3-max-HEVC-encoding-resolut.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyMWY1NzdhNTQ1OGQ4NDA0MWE0MWE5MDQxYmY4YWE5ZTEwZmY0NmI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9uZyBUaGFpIDx0aG9uZy50aGFpQGFtZC5jb20+CkRhdGU6
IE1vbiwgMSBNYXkgMjAyMyAxMTowNDozNiAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRn
cHUvbnY6IHVwZGF0ZSBWQ04gMyBtYXggSEVWQyBlbmNvZGluZyByZXNvbHV0aW9uCgpVcGRhdGUg
dGhlIG1heGltdW0gcmVzb2x1dGlvbiByZXBvcnRlZCBmb3IgSEVWQyBlbmNvZGluZyBvbiBWQ04g
MwpkZXZpY2VzIHRvIHJlZmxlY3QgaXRzIDhLIGVuY29kaW5nIGNhcGFiaWxpdHkuCgp2MjogQWxz
byB1cGRhdGUgdGhlIG1heCBoZWlnaHQgZm9yIEguMjY0IGVuY29kaW5nIHRvIG1hdGNoIHNwZWMu
CihSdWlqaW5nKQoKU2lnbmVkLW9mZi1ieTogVGhvbmcgVGhhaSA8dGhvbmcudGhhaUBhbWQuY29t
PgpSZXZpZXdlZC1ieTogUnVpamluZyBEb25nIDxydWlqaW5nLmRvbmdAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jIHwgMjQgKysrKysrKysrKysrKysrKysrLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvbnYuYwppbmRleCAzY2MwNjg5NzRiY2QuLjdkNDM3YjgyMTU5ZSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9udi5jCkBAIC05OCw2ICs5OCwxOCBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGFtZGdwdV92aWRlb19jb2RlY3MgbnZfdmlkZW9fY29kZWNzX2RlY29kZSA9CiB9OwogCiAv
KiBTaWVubmEgQ2ljaGxpZCAqLworc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfdmlkZW9fY29k
ZWNfaW5mbyBzY192aWRlb19jb2RlY3NfZW5jb2RlX2FycmF5W10gPQoreworCXtjb2RlY19pbmZv
X2J1aWxkKEFNREdQVV9JTkZPX1ZJREVPX0NBUFNfQ09ERUNfSURYX01QRUc0X0FWQywgNDA5Niwg
MjE2MCwgMCl9LAorCXtjb2RlY19pbmZvX2J1aWxkKEFNREdQVV9JTkZPX1ZJREVPX0NBUFNfQ09E
RUNfSURYX0hFVkMsIDc2ODAsIDQzNTIsIDApfSwKK307CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
YW1kZ3B1X3ZpZGVvX2NvZGVjcyBzY192aWRlb19jb2RlY3NfZW5jb2RlID0KK3sKKwkuY29kZWNf
Y291bnQgPSBBUlJBWV9TSVpFKHNjX3ZpZGVvX2NvZGVjc19lbmNvZGVfYXJyYXkpLAorCS5jb2Rl
Y19hcnJheSA9IHNjX3ZpZGVvX2NvZGVjc19lbmNvZGVfYXJyYXksCit9OworCiBzdGF0aWMgY29u
c3Qgc3RydWN0IGFtZGdwdV92aWRlb19jb2RlY19pbmZvIHNjX3ZpZGVvX2NvZGVjc19kZWNvZGVf
YXJyYXlfdmNuMFtdID0KIHsKIAl7Y29kZWNfaW5mb19idWlsZChBTURHUFVfSU5GT19WSURFT19D
QVBTX0NPREVDX0lEWF9NUEVHMiwgNDA5NiwgNDA5NiwgMyl9LApAQCAtMTM2LDggKzE0OCw4IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3ZpZGVvX2NvZGVjcyBzY192aWRlb19jb2RlY3Nf
ZGVjb2RlX3ZjbjEgPQogLyogU1JJT1YgU2llbm5hIENpY2hsaWQsIG5vdCBjb25zdCBzaW5jZSBk
YXRhIGlzIGNvbnRyb2xsZWQgYnkgaG9zdCAqLwogc3RhdGljIHN0cnVjdCBhbWRncHVfdmlkZW9f
Y29kZWNfaW5mbyBzcmlvdl9zY192aWRlb19jb2RlY3NfZW5jb2RlX2FycmF5W10gPQogewotCXtj
b2RlY19pbmZvX2J1aWxkKEFNREdQVV9JTkZPX1ZJREVPX0NBUFNfQ09ERUNfSURYX01QRUc0X0FW
QywgNDA5NiwgMjMwNCwgMCl9LAotCXtjb2RlY19pbmZvX2J1aWxkKEFNREdQVV9JTkZPX1ZJREVP
X0NBUFNfQ09ERUNfSURYX0hFVkMsIDQwOTYsIDIzMDQsIDApfSwKKwl7Y29kZWNfaW5mb19idWls
ZChBTURHUFVfSU5GT19WSURFT19DQVBTX0NPREVDX0lEWF9NUEVHNF9BVkMsIDQwOTYsIDIxNjAs
IDApfSwKKwl7Y29kZWNfaW5mb19idWlsZChBTURHUFVfSU5GT19WSURFT19DQVBTX0NPREVDX0lE
WF9IRVZDLCA3NjgwLCA0MzUyLCAwKX0sCiB9OwogCiBzdGF0aWMgc3RydWN0IGFtZGdwdV92aWRl
b19jb2RlY19pbmZvIHNyaW92X3NjX3ZpZGVvX2NvZGVjc19kZWNvZGVfYXJyYXlfdmNuMFtdID0K
QEAgLTIzNywxMiArMjQ5LDEyIEBAIHN0YXRpYyBpbnQgbnZfcXVlcnlfdmlkZW9fY29kZWNzKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBib29sIGVuY29kZSwKIAkJfSBlbHNlIHsKIAkJCWlm
IChhZGV2LT52Y24uaGFydmVzdF9jb25maWcgJiBBTURHUFVfVkNOX0hBUlZFU1RfVkNOMCkgewog
CQkJCWlmIChlbmNvZGUpCi0JCQkJCSpjb2RlY3MgPSAmbnZfdmlkZW9fY29kZWNzX2VuY29kZTsK
KwkJCQkJKmNvZGVjcyA9ICZzY192aWRlb19jb2RlY3NfZW5jb2RlOwogCQkJCWVsc2UKIAkJCQkJ
KmNvZGVjcyA9ICZzY192aWRlb19jb2RlY3NfZGVjb2RlX3ZjbjE7CiAJCQl9IGVsc2UgewogCQkJ
CWlmIChlbmNvZGUpCi0JCQkJCSpjb2RlY3MgPSAmbnZfdmlkZW9fY29kZWNzX2VuY29kZTsKKwkJ
CQkJKmNvZGVjcyA9ICZzY192aWRlb19jb2RlY3NfZW5jb2RlOwogCQkJCWVsc2UKIAkJCQkJKmNv
ZGVjcyA9ICZzY192aWRlb19jb2RlY3NfZGVjb2RlX3ZjbjA7CiAJCQl9CkBAIC0yNTEsMTQgKzI2
MywxNCBAQCBzdGF0aWMgaW50IG52X3F1ZXJ5X3ZpZGVvX2NvZGVjcyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgYm9vbCBlbmNvZGUsCiAJY2FzZSBJUF9WRVJTSU9OKDMsIDAsIDE2KToKIAlj
YXNlIElQX1ZFUlNJT04oMywgMCwgMik6CiAJCWlmIChlbmNvZGUpCi0JCQkqY29kZWNzID0gJm52
X3ZpZGVvX2NvZGVjc19lbmNvZGU7CisJCQkqY29kZWNzID0gJnNjX3ZpZGVvX2NvZGVjc19lbmNv
ZGU7CiAJCWVsc2UKIAkJCSpjb2RlY3MgPSAmc2NfdmlkZW9fY29kZWNzX2RlY29kZV92Y24wOwog
CQlyZXR1cm4gMDsKIAljYXNlIElQX1ZFUlNJT04oMywgMSwgMSk6CiAJY2FzZSBJUF9WRVJTSU9O
KDMsIDEsIDIpOgogCQlpZiAoZW5jb2RlKQotCQkJKmNvZGVjcyA9ICZudl92aWRlb19jb2RlY3Nf
ZW5jb2RlOworCQkJKmNvZGVjcyA9ICZzY192aWRlb19jb2RlY3NfZW5jb2RlOwogCQllbHNlCiAJ
CQkqY29kZWNzID0gJnljX3ZpZGVvX2NvZGVjc19kZWNvZGU7CiAJCXJldHVybiAwOwotLSAKMi40
MC4xCgo=

--------------DteoM0IwJCMAJ3c0QxuX7A5Z--
