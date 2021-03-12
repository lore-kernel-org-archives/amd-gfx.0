Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17DCC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 10:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9A565002
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 10:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9A565002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63BD16F550;
	Fri, 12 Mar 2021 10:24:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 915E66F550
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 10:24:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRdG0uWTqrHezU+0PyEqz0wQ5oDhoKxab9fkfbuuPZdiAsLwtMbPuw3jCB50wmOEKp2rPD63qY4H8a0ZEFzZ2Yh+Q6xCxOI0YKPCnHIqXP+xIUiZJ5x8ZitgczfJjrNUK8m9Tayx0D3KNyFzyfc7CBGAS+R8zPSJuP6vNv5SYG9wn/x1ohNUMhg4nC+62kclTEOYz6V7yClM4ZaG0n2pzAUrU39ipvnaHFDDn5ZMV08NAwhwJ31s7I0oi5vT414NYJBnKcb+Odw41Hth0fgT+Uut7K0Q1qhpaQocq0bJk3NGzdPFJiWjGaE/HW6/d0CHxHLIvZCFiQP1vj2LCGdy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvcKQpitVwtWQPRI85OZYc5SA/to94/iJETxQJNzEFQ=;
 b=DJs9Lq2Va+GivmcwJlSwC0e/CULtIK2HRom+yYu/0vuNGUHT3WZZjR2ZxCXOejnl3mgwHimQdAMWEce1CIWqNmrfcFRTgrl4n5wvEvlik7859u9f4Yzy+EzDaus4Md6dMi8rqQ7UWuPiQTsyUGL1iRsxIcyewL05HFgeh2mBdRM8248VgMYj9ttZce5inaYUlrNLKK9zOjOuwCOGgcoJGRZxr2eee2FF1/nwPk/CMDuioQlKWiCDgDLEdzJymU8QP5lPzuVX5Doxxej3md7Pe32xAolEvFw4iAP+/2TD7kM7djMQBmObJL/x+DpVkqoFdS/WUl40x3kqjgMKQYRb5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvcKQpitVwtWQPRI85OZYc5SA/to94/iJETxQJNzEFQ=;
 b=Ue8lFfn1c0P/PEMsvVZmtHB8NEuZ7hrQFE1Z5xJ8z6rmbeZHhbS3n2qCPcfh2bV1LLmyvfo/7JD7zOaDiem5hISZfCAax78ix2sLCh/jLksgspEksaqnZvKPA/Mgc4yFaAQR+DM9uBVBSozNXsKjlkgPSAmEkbKgeyOPIm7R5H8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1174.namprd12.prod.outlook.com (2603:10b6:903:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Fri, 12 Mar
 2021 10:24:49 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 10:24:49 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: wrap kiq ring ops with kiq spinlock
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>
References: <20210312094901.20245-1-nirmoy.das@amd.com>
 <8410721d-666b-567d-c2c3-2641fd8217a3@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <312aff09-85ca-9599-0bd5-751f86aed5c6@amd.com>
Date: Fri, 12 Mar 2021 11:24:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <8410721d-666b-567d-c2c3-2641fd8217a3@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.104.81]
X-ClientProxiedBy: AM0PR04CA0126.eurprd04.prod.outlook.com
 (2603:10a6:208:55::31) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.104.81) by
 AM0PR04CA0126.eurprd04.prod.outlook.com (2603:10a6:208:55::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 10:24:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4df032b2-59d8-4ad0-fd3d-08d8e541111c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1174ACD2820EBFBE213CBA998B6F9@CY4PR12MB1174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sv7mJxOFdNLEyguSNgYogvfkDoaMrelQ5QAqI1v+c5lrgbddF4KJDNUkO4Gw5ccgHxjrUOOyRw57QrnKD9/my1Fn2DYaeflIFGql8LEiyIpmDjUU/jnVLTtU6zYfuqmBdQAAzh0U7qJ0sfMI2lAth57M+xZqZtNebdXxLMXW4Yr3lgAvqbkZHLddVI7HRgA86iocN7/ZxDYQKwwKdotsL1jrltHsQTZcu4kyRgBJkOkH/iNjQiqfiAHB4YOOpC7RjMUXWH81+Vkb/s/AO2+Lw5wFM1c1DK/rZd5oAOLFz+2Rph5eiP4Yy9ZnsP4WDI2JfFzmN5NLUiQ3pDlLx9ZzSHy7y/yFI6p9SUQ+js9w07+9ZpD3G5x33kz25VQVH71mU8nuW8n+zEBSHoczx/Wge9pLmK3dvLKPx+V66gHjHMvnzsxb3XDo4Ro8ynswFPqHU+nj4esZzTxce2grxJFLBUDAU5Gp+RHQTdI5/eO5+tVpwpixmrnMRAa3OWq4f6m+mEiwauLyp3dbQS+czS566EdsxFPL71LcHI0diapLyNqzGWd5PiXSLZ8Pn15vGb+UVH1Abnj+syTF+gVJ3D+gmDJc/Dpc/YIgjX6N2uVtzDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(2906002)(6666004)(478600001)(6486002)(6636002)(31696002)(8676002)(956004)(16526019)(2616005)(31686004)(26005)(186003)(8936002)(66946007)(66574015)(110136005)(316002)(52116002)(83380400001)(16576012)(36756003)(5660300002)(4326008)(53546011)(66556008)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a2Y2UWMvVDhFZ1JtRHNvVXFQWlFCT3dFcnVZNWE1S3lVM29IUDFuTmV4V2t4?=
 =?utf-8?B?bDc2cFgxMDRmbEhRM3RBbVYyTlNreHJDKzdsWkN5RnFEVnFCZ0V5R2VEbEI3?=
 =?utf-8?B?T0dZakpOaGlNRGJmTnVwZnZ0eXQxR3d5SUFuVE1LNjg4UFcyUEY5NndSQllk?=
 =?utf-8?B?SHRJRitsc1JFMVF1d3AwWXdGVW9uYS9XblJnc0UyQW9CRXRRNTlEU1JPbGJP?=
 =?utf-8?B?bTAwd3htZSttVE0zNjQ5TXZWdGpmUERZZ2JQVmJGRW5IOU40a0NiZFRBeitu?=
 =?utf-8?B?eUM0UkhsYmpOY2ZuUVdSRHhndlhlTVRvdk5rMEQvSS82c1JkUmp3ZDF5aG91?=
 =?utf-8?B?aGpVTGIyRUdTdUI0Qy9BMXhuRGhhSlgxcmRJUGt3NWI1NWN5SE5xblJtK2pj?=
 =?utf-8?B?bUlhaVJncDFTTmFuWTNIRlc0K2ZzOVpJMll3Q05KajNhNE5JRSs2TFZlYjg3?=
 =?utf-8?B?VFJ4MENNL2d3UzhWdUhXblp3WExnaS9PR2NTUkhuRUFQNk9aZ1ZseHhDdHdE?=
 =?utf-8?B?WlBTK01kK3FZeVludUk0Z3p6SUticzh2bWs4MHFhelBWT2RsaFV5NG5FVDcz?=
 =?utf-8?B?dlVzOGZYOVIxYjhwcC9IS0IzQnZrOVoxZG9wWmtxK2FGeEh0cGpiQWp0ZFIr?=
 =?utf-8?B?cmxaZVcwVnRaa2YrVHIzOUJLZ1dTT0pSM3FCRVJja2lyNTJkTHA5S1F3K0E0?=
 =?utf-8?B?QTNQWE1EcjJyVUN2Z1FpUGQ5Wm81R0dpcjV6cHk4TTI5YTJFOCtJbzZWUU9J?=
 =?utf-8?B?WHdsczNITmNCdEFqbVI3TEc0OG5EUDZhSWZFOVgzd0RoMHMyQ3R3VXBxQnRD?=
 =?utf-8?B?M2JXc0pmN2tBZndmVE1HZ0ptdlJpOGhZbFNLb2Rub21WY2RieFYyQmllZHNm?=
 =?utf-8?B?V2VMbEFYNUhmM1ZkUFlDazNhc0pvUnNmeXE2eWU2V09VQWMrZDFrYVVjVmh5?=
 =?utf-8?B?QnNWL3hrMWM2Vkd2enRVQ3JpVTN6ZGJGVHJtNmtnTlJseVl3RFlxMEVncis5?=
 =?utf-8?B?dXhsNU9pWEUzcUlOd3lBaGZ0bXVMM3AyRFR5MXhGSGluRXdHdVpiRWphT3J5?=
 =?utf-8?B?Ui9CZ3dxUDgwRGtYNURheTNFbFo3WFlhOEtrYWZ6VjU2ZHRJRHJGMFdCNEdn?=
 =?utf-8?B?TVRpNThBYnN3ejVYbHh1bE9OOVhoQ2dMT0ozWE02SnlCa2VGTEVQaFVXZWsr?=
 =?utf-8?B?VEowSXdLbnRPZk5QTjFKazRYSTF6U0RrdGMvSUFNZEMvV3NKTE5jbG5JUVBK?=
 =?utf-8?B?UFUzWnZMM1kwVW1HVm9VOUtxVW04S1BEOVduTXVDcEJ5TE9Jc0QvcEFaYnBm?=
 =?utf-8?B?cHNQcGQ5djRHR2JQb3JYS2xxR1p5RGdGeEg1OTlpdEZrUjk1czB4dkFma1BM?=
 =?utf-8?B?MGNjcDlTM3l1MkkzdC83cVkrbnR5T21DTFhtYjhTNi9jS1QyWlMxRkJtS0JC?=
 =?utf-8?B?dGpKWXh5bnVTMVhCTXMwWWdDd1AvYW1lYW1MVHNTYmcweGw4SHNvdEtTemFx?=
 =?utf-8?B?d3NIMFR3SzgwaVVVUEhpSUZqckt6bnNBS05JSnkwSGJYV2lNVnRQbk11Rktw?=
 =?utf-8?B?b2VJZ0wyUWpaUWpjM2VXRkVMeWc5enlQWmpsSDRRbmVwckk1RFBPZjFBc3E3?=
 =?utf-8?B?Uk1GS2lRcWpjKzEvWlZjMUVQNi9walFnNHNtWDA4NURkTFN6OGJVVmk3dnJZ?=
 =?utf-8?B?M1h5bXJyR3FwdjFCSWRrSHg2M05aQmxpQlRHckJBdytLa09idGhReWR3NlBS?=
 =?utf-8?Q?ERcNx7WrdLONw5ix+VITPfz0la3Yl4MwVr9pap7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df032b2-59d8-4ad0-fd3d-08d8e541111c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 10:24:49.7321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iw5on4ehNW7wc2Z0oz6myPl06CuOVSk47EO/c7ZF9az1pwc/0Q6pCjNhJXLTLbZn0Ipe2qQIUKgbgTR6BZmosA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1174
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDMvMTIvMjEgMTA6NTIgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTIuMDMu
MjEgdW0gMTA6NDkgc2NocmllYiBOaXJtb3kgRGFzOgo+PiBLSVEgcmluZyBpcyBiZWluZyBvcGVy
YXRlZCBieSBrZmQgYXMgd2VsbCBhcyBhbWRncHUuCj4+IEtGRCBpcyB1c2luZyBraXEgbG9jaywg
d2Ugc2hvdWxkIHRoZSBzYW1lIGZyb20gYW1kZ3B1IHNpZGUKPj4gYXMgd2VsbC4KPgo+IEFoLCBu
b3cgSSBrbmV3IHdoaWNoIGZ1bmN0aW9ucyB5b3UgbWVhbi4gVGhpcyBpcyBub3Qgc3RyaWN0bHkg
Cj4gbmVjZXNzYXJ5IGJlY2F1c2UgdGhhdCBzdHVmZiBpcyBvbmx5IGNhbGxlZCBkdXJpbmcgYm9v
dHVwIGFuZCBub3QgCj4gbGF0ZXIgb24uCgoKT0ssIG5vdCBzbyBzZXJpb3VzIGlzc3VlIGFzIEkg
d2FzIHRoaW5raW5nIHRoZW4uCgoKPgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxu
aXJtb3kuZGFzQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ2Z4LmMgfCAxMCArKysrKysrKy0tCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dmeC5jCj4+IGluZGV4IDE5MTViOWI5NTEwNi4uOGZlMzcwZTUzNThkIDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMKPj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jCj4+IEBAIC00Njcs
MTMgKzQ2NywxNyBAQCBpbnQgYW1kZ3B1X2dmeF9kaXNhYmxlX2tjcShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAKPj4gKmFkZXYpCj4+IMKgwqDCoMKgwqAgaWYgKCFraXEtPnBtZiB8fCAha2lxLT5wbWYt
PmtpcV91bm1hcF9xdWV1ZXMpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsK
Pj4gwqAgK8KgwqDCoCBzcGluX2xvY2soJmFkZXYtPmdmeC5raXEucmluZ19sb2NrKTsKPj4gwqDC
oMKgwqDCoCBpZiAoYW1kZ3B1X3JpbmdfYWxsb2Moa2lxX3JpbmcsIGtpcS0+cG1mLT51bm1hcF9x
dWV1ZXNfc2l6ZSAqCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBh
ZGV2LT5nZngubnVtX2NvbXB1dGVfcmluZ3MpKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYWRldi0+Z2Z4Lm51bV9jb21wdXRlX3JpbmdzKSkgewo+PiArwqDCoMKg
wqDCoMKgwqAgc3Bpbl91bmxvY2soJmFkZXYtPmdmeC5raXEucmluZ19sb2NrKTsKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOwo+PiArwqDCoMKgIH0KPj4gwqAgwqDCoMKgwqDC
oCBmb3IgKGkgPSAwOyBpIDwgYWRldi0+Z2Z4Lm51bV9jb21wdXRlX3JpbmdzOyBpKyspCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBraXEtPnBtZi0+a2lxX3VubWFwX3F1ZXVlcyhraXFfcmluZywgCj4+
ICZhZGV2LT5nZnguY29tcHV0ZV9yaW5nW2ldLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUkVTRVRfUVVFVUVTLCAwLCAwKTsKPj4gK8KgwqDCoCBz
cGluX3VubG9jaygmYWRldi0+Z2Z4LmtpcS5yaW5nX2xvY2spOwo+PiDCoCDCoMKgwqDCoMKgIHJl
dHVybiBhbWRncHVfcmluZ190ZXN0X2hlbHBlcihraXFfcmluZyk7Cj4KPiBUaGUgcmluZyB0ZXN0
IGFjY2Vzc2VzIHRoZSByaW5nIGJ1ZmZlciBhcyB3ZWxsLgoKClNoYWxsIEkgc2VuZCBhIHYyID8K
CgpUaGFua3MsCgpOaXJtb3kKCgo+Cj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPgo+PiDCoCB9
Cj4+IEBAIC01MTgsMTggKzUyMiwyMCBAQCBpbnQgYW1kZ3B1X2dmeF9lbmFibGVfa2NxKHN0cnVj
dCBhbWRncHVfZGV2aWNlIAo+PiAqYWRldikKPj4gwqAgwqDCoMKgwqDCoCBEUk1fSU5GTygia2lx
IHJpbmcgbWVjICVkIHBpcGUgJWQgcSAlZFxuIiwga2lxX3JpbmctPm1lLCAKPj4ga2lxX3Jpbmct
PnBpcGUsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAga2lxX3JpbmctPnF1ZXVlKTsKPj4gLQo+PiArwqDCoMKgIHNwaW5fbG9jaygm
YWRldi0+Z2Z4LmtpcS5yaW5nX2xvY2spOwo+PiDCoMKgwqDCoMKgIHIgPSBhbWRncHVfcmluZ19h
bGxvYyhraXFfcmluZywga2lxLT5wbWYtPm1hcF9xdWV1ZXNfc2l6ZSAqCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGV2LT5nZngubnVtX2NvbXB1dGVfcmlu
Z3MgKwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2lxLT5w
bWYtPnNldF9yZXNvdXJjZXNfc2l6ZSk7Cj4+IMKgwqDCoMKgwqAgaWYgKHIpIHsKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIERSTV9FUlJPUigiRmFpbGVkIHRvIGxvY2sgS0lRICglZCkuXG4iLCByKTsK
Pj4gK8KgwqDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrKCZhZGV2LT5nZngua2lxLnJpbmdfbG9jayk7
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcjsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgIMKg
wqDCoMKgwqAga2lxLT5wbWYtPmtpcV9zZXRfcmVzb3VyY2VzKGtpcV9yaW5nLCBxdWV1ZV9tYXNr
KTsKPj4gwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgYWRldi0+Z2Z4Lm51bV9jb21wdXRlX3Jp
bmdzOyBpKyspCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBraXEtPnBtZi0+a2lxX21hcF9xdWV1ZXMo
a2lxX3JpbmcsIAo+PiAmYWRldi0+Z2Z4LmNvbXB1dGVfcmluZ1tpXSk7Cj4+ICvCoMKgwqAgc3Bp
bl91bmxvY2soJmFkZXYtPmdmeC5raXEucmluZ19sb2NrKTsKPj4gwqAgwqDCoMKgwqDCoCByID0g
YW1kZ3B1X3JpbmdfdGVzdF9oZWxwZXIoa2lxX3JpbmcpOwo+PiDCoMKgwqDCoMKgIGlmIChyKQo+
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
