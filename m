Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948A1C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4306D64E9B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4306D64E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E11056E5BB;
	Mon,  1 Feb 2021 15:23:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CDB16E5BB
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 15:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuYn6KiSwV0cIwt0rpVz8Xrp/ZNUFueeikoh5k1CqCnVZpkB/M2Xj90FZyow6rwbOf3NelB+27IEvaMa7AvRMmVExdP7nk0Xrqj8YCSspnx7yU07Q5SQgrn9SOj6T56i63tRrwn2Yc6xCnk1G9cb7ndbN3I0j81otXRXC1XHgHrzcXrtk+9OyxXY0MUgPTtbwfTDvDyTTkhr6IxKdXmsl0Yj6liEDuDRtziFMqI49KuNAog56f+EJ9WkxuKLktHwOSHfriZuG7GgWy7r0NxFk75yweM/RyORyzJPeuNFf74uv4yLqUnBf8m953mbptbpVXVtubjkQSU5VM8SPqKyxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LABSkCOXiysYRPGoz6MVuwfDhhAOeMMug8AmI93aG0k=;
 b=ml+9ng2laNJfODGkRABzycoe5Q/BNaUPUvfDKKWeAtaaDITAZuUh4sBjle6x7A42gIBW/pKimQXIkeQjC+GhI1L+irDgOOyvpsf9z0sPS8WghkIwToRJJyTxg0lDQuMqHrUHscQ0Mqx7ZhlYX8AdIGoGNekZMkCl0bh+4i0s+WhePf5ustcNibKQEqSbQcmqe0vwFjShrQEp9IvuqGw4uYALjfhGob9Oy9LoPIzU4frs7M2JxAsY5qAdMy1oEzVSYgQ0LBWCmV/MoH5JfbkKD/XvH2U/41iwfeLJcqQzCgQ93vkCSJRTF4q27C+Ya5FruVPWUpiiAJq3v3uPWOSyHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LABSkCOXiysYRPGoz6MVuwfDhhAOeMMug8AmI93aG0k=;
 b=ZvvK8LentdUEqRXrGSmSTffQmxoJNMwn/u+9n4+rElwOBVtd6pD0IrMBF/oH8sgcHrzP5KPDTmXEQCdI4LHOac+X87yzI81tjtLx3jpPnbr1M28grWYOBu3gFOriFDa1/jCQ1WfDA9xgPnJgkQPn+DVaKWaisuBTn4kUaOlY1y0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Mon, 1 Feb
 2021 15:23:30 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 15:23:30 +0000
Subject: Re: [PATCH] drm/amdgpu: enable freesync for A+A configs
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210201143408.81475-1-christian.koenig@amd.com>
 <2226fb7c-97e5-ba63-041d-219902e56dbe@amd.com>
 <7c3deeb7-8dfd-5a04-297f-292c4d1ded79@gmail.com>
 <101a7093-8dd0-80bf-9f31-79d08af809d7@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5a8106c6-0998-5347-5508-ad5d6ed7111a@amd.com>
Date: Mon, 1 Feb 2021 16:23:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <101a7093-8dd0-80bf-9f31-79d08af809d7@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR05CA0076.eurprd05.prod.outlook.com
 (2603:10a6:208:136::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR05CA0076.eurprd05.prod.outlook.com (2603:10a6:208:136::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Mon, 1 Feb 2021 15:23:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d732c64-25bb-438e-5970-08d8c6c5541b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4375:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4375D6DDDB39795E1E61085E83B69@MN2PR12MB4375.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKotQmz5k4THveqfiTo/YChLIyAISve/iz2Z9lpq50tc2Mcr7zd2QOpYG0v+ZRA8fn52dqlxQlAsf+i+zXGNVNJ9aiuHqzPPJBUrZShKDo9qTyiTBZNI3g4Rhc0mwooJIOW9X/EdCs/2Em/GK3ywUcR6hmDbP13ZzJ5CApj2Nm9phVB/zaUM19nEiRCkg9WF/f8V+OkioF3W1z8TMXEmd30HL3uLRu1AyMVfbb4czykJHDD1Tt8jqWJMRv6s2kCb/Ds8UezE7HYa0q+Umq2G2WH9WUocc8NtsGZmsKz3fg3y+eBJXB1lMCXOEG0KMzJOyMnnaW+c6gKrEbpsVpC4Tnqb7BzLCZVH+xXtIFoWNWpRu8MAkzNiFOJyDOkZkU+eZ3d6U5v5e3mhObj5o6mwIsYgmyJN4GSfIy3CDqGzjh0sO5vvcWfgwDQxarnxCEwPVmVwsZNnyKGL+IMyASPKUIlEs2rtp/sQ0DbyFORYlET43hBAp/k+oUIKtPzPkZrKJdEtY6++Gyn8l36ankaHnRKZyT3EvlaQ1zXHhvseZD+zdJPXoYxAhx/WxrfLzKVCm5P4oIA1LGyYwp4EZCJFG9PGQMqiET5AKn7jAz9Cwv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(53546011)(2906002)(86362001)(31696002)(186003)(478600001)(5660300002)(66476007)(2616005)(16526019)(66556008)(8676002)(66946007)(8936002)(6666004)(36756003)(316002)(31686004)(6486002)(83380400001)(66574015)(52116002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RUlmLzlkMUR5cDRzeGNaWVI3bEJKSHhQbm96eEhjdENCVW5LNkVFQU03ZlJM?=
 =?utf-8?B?V3pxbFgzZG9pemJiVGt4Vm5CdTBHcEtLY0toeXJzY2QwNW1laHpLb3JhNHZl?=
 =?utf-8?B?cFJGVTBxd3ZJbmtLdHhpOHI3RVRxRjRmT2QwYUpvcUc0S21MMVFnbkdRWHMx?=
 =?utf-8?B?Q1RxUzNBUXZKU0E4R0lHRkpFRVFGTFAraEZxT3RYZmFwYkl5UzZVNUJZa21k?=
 =?utf-8?B?eHZScnoxMW9meFlmdHI5TjYzN0RiaGt4M0JjL3BNRDEyUlBFZUpDWlVtclR1?=
 =?utf-8?B?NDlQSDh6R1E4aFAybzI4OCt5aUdjZmgwaDlFd0lSVmVsQXR0MHVIWlc0OEt3?=
 =?utf-8?B?ZnA5R2Q0bHZGZ3RNQnNOcldlRFZvdUtNOFhsUnUxMkczZDV3OFR0azBZalI2?=
 =?utf-8?B?L0J4Y1I3aE1jQ2xTQmEvZ0VKUkZRdEFRa0F4RUJIbFM5UXR6c0RVQmF5Q21K?=
 =?utf-8?B?ZWZncWVjUFk4Q2dzMU5KTzM1NGRjU2hvNWZodjB4Z0twVm5nUnIyenZ2bUZk?=
 =?utf-8?B?TDNUTVdiMEc2c2U4UlFZMnVMa0JjN0tXcFlueGFOdlRGVUJiZjlxMGxVNktZ?=
 =?utf-8?B?aWlTNG9sUHM0R0svaGZMTW03Q01vTGtsejU0WDZoamNROTdDOXBWRmp0ZUs3?=
 =?utf-8?B?UUt3VDdFSzZhMzBPN2RZT2NiOXo0WXhGQUxvVlpGb1ZJUHN2Yk40WG1rWmxG?=
 =?utf-8?B?Nit4Q2txUWIzT29lTnZ1ZmJjRVY3WmhXalg4UnFjb1ZXa3U1MG5JTUVQWnRG?=
 =?utf-8?B?SGwweWgvL0t6ZXZhaDNxYXV6MVhic00rdVlCc3UrdlcvZnFvMi8rT3U1Zk54?=
 =?utf-8?B?K2l5aFlLcmRNMmM4ejlNbXhCaEc0eFdUYXF3MFJkUkxhT2dmTEJ6K1phUW5w?=
 =?utf-8?B?Unp6bWlES1IxWHkvUFNwQlR4MHBFcEowSThWOWUvc2lDZXVYQmJrOVcvcDRO?=
 =?utf-8?B?WHBSdkZ1bXdKRlkyaFQ1WW9FRlNIRkdZeDRRdFlLOWoxd0xGbXBhazFTcUoy?=
 =?utf-8?B?ekZGVUY1WTc5amZ4anMydzE1WGdJRU5rQkw4dU5xYkpwZm9ad09DY1V2Q2dS?=
 =?utf-8?B?TkZFakVkVmdLanJrc0VrOHdtL3ZxUklrVG0xRC9QNkZuL1JqTkpTMGFGYzky?=
 =?utf-8?B?NGVUWGhGL1ladFRuRW04MmtaWGdtdUhIM09HS0pYVDJheDZXU0wxT1Y1SVlH?=
 =?utf-8?B?R2NTR1NmeTAyMTFGaVFmMC9EcWI1YWlsM2FrNXgyb2Z2QlBxRklZZkJ2b0lM?=
 =?utf-8?B?NVNIcHhCZ2xpNU43K1hZMzZSU0tSejc4U1F6VDhsT3NxZGFabmprbU81aS9a?=
 =?utf-8?B?aDluVDh5eDZBbXRxblhISEtmMllrRGdBU2JHTmt6UUZJdFFhL3ZvRkRiaklm?=
 =?utf-8?B?cDdmWUwxazdnQjh2cm9BVk5ZK2trZGJYc1RYL0YzSTNlV0IzaCsra2pad09s?=
 =?utf-8?B?RTMrYmNkT2Z1bGNuMzkyQ1RONzYyVWdVdjhMNHJpQlFKY1Q5UmNCYzNKd3ow?=
 =?utf-8?Q?jzUDa86WoBAiy+jBS957qiQxWiG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d732c64-25bb-438e-5970-08d8c6c5541b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 15:23:30.2706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lj7Nckg5KmecsRN7BAgO0ipmUBsZdzQv3bi7iZHe0S0cCXQ/u77tBxK2HFGWKdNe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
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

QW0gMDEuMDIuMjEgdW0gMTY6MTMgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4gT24gMDEvMDIv
MjEgODozOSBwbSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMDEuMDIuMjEgdW0gMTY6
MDYgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+PiBIZWxsbyBDaHJpc3RpYW4sCj4+Pgo+Pj4g
T24gMDEvMDIvMjEgODowNCBwbSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+PiBTb21lIG5l
d2VyIEFQVXMgY2FuIHNjYW5vdXQgZGlyZWN0bHkgZnJvbSBHVFQsIHRoYXQgc2F2ZXMgdXMgZnJv
bQo+Pj4+IGFsbG9jYXRpbmcgYW5vdGhlciBib3VuY2UgYnVmZmVyIGluIFZSQU0gYW5kIGVuYWJs
ZXMgZnJlZXN5bmMgaW4gc3VjaAo+Pj4+IGNvbmZpZ3VyYXRpb25zLgo+Pj4gU2hhbGwgd2UgYWRk
IHNvbWUgbW9yZSBkZXRhaWxzIGFib3V0IGhvdyB0aGlzIHBhdGNoIGhlbHBzIHdpdGggVlJSLCBs
aWtlICJXaXRob3V0IHRoaXMgcGF0Y2gsIGl0IHdvbid0IGJlIHBvc3NpYmxlIGZvciB0aGUgSUdQ
VSB0byBmbGlwIGJ1ZmZlcnMgd2hpY2ggYXJlIGNvbXBvc2VkIG9uIGFuIGV4dGVybmFsIEdQVSIg
b3Igc29tZXRoaW5nIGluIHRob3NlIGxpbmVzID8KPj4gSG93IGFib3V0Ogo+Pgo+PiAiV2l0aG91
dCB0aGlzIHBhdGNoIGNyZWF0aW5nIGEgZnJhbWVidWZmZXIgZnJvbSB0aGUgaW1wb3J0ZWQgQk8g
d2lsbAo+PiBmYWlsIGFuZCB1c2Vyc3BhY2Ugd2lsbCBmYWxsIGJhY2sgdG8gYSBjb3B5Ii4KPiBZ
ZXAsIGxvb2tzIGdvb2QgZW5vdWdoLiBUaGVyZSBpcyBqdXN0IG9uZSBtb3JlIHRpbnkgY29tbWVu
dCBiZWxvdywgcGxlYXNlIGNoZWNrIHRoYXQgb3V0IHRvby4KPgo+PiBUaGFua3MsCj4+IENocmlz
dGlhbi4KPj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Cj4+Pj4gLS0tCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rpc3BsYXkuYyB8IDggKysrKysrLS0KPj4+PiAgICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgIHwgMiArLQo+Pj4+ICAgIDIgZmlsZXMgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jCj4+Pj4gaW5kZXggYTYzODcwOWU5Yzky
Li44MjNiYzI1ZDg3ZGUgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rpc3BsYXkuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kaXNwbGF5LmMKPj4+PiBAQCAtOTMwLDggKzkzMCwxMCBAQCBhbWRncHVfZGlzcGxh
eV91c2VyX2ZyYW1lYnVmZmVyX2NyZWF0ZShzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LAo+Pj4+ICAg
IAkJCQkgICAgICAgc3RydWN0IGRybV9maWxlICpmaWxlX3ByaXYsCj4+Pj4gICAgCQkJCSAgICAg
ICBjb25zdCBzdHJ1Y3QgZHJtX21vZGVfZmJfY21kMiAqbW9kZV9jbWQpCj4+Pj4gICAgewo+Pj4+
IC0Jc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmo7Cj4+Pj4gICAgCXN0cnVjdCBhbWRncHVfZnJh
bWVidWZmZXIgKmFtZGdwdV9mYjsKPj4+PiArCXN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqOwo+
Pj4+ICsJc3RydWN0IGFtZGdwdV9ibyAqYm87Cj4+Pj4gKwl1aW50MzJfdCBkb21haW5zOwo+Pj4+
ICAgIAlpbnQgcmV0Owo+Pj4+ICAgIAo+Pj4+ICAgIAlvYmogPSBkcm1fZ2VtX29iamVjdF9sb29r
dXAoZmlsZV9wcml2LCBtb2RlX2NtZC0+aGFuZGxlc1swXSk7Cj4+Pj4gQEAgLTk0Miw3ICs5NDQs
OSBAQCBhbWRncHVfZGlzcGxheV91c2VyX2ZyYW1lYnVmZmVyX2NyZWF0ZShzdHJ1Y3QgZHJtX2Rl
dmljZSAqZGV2LAo+Pj4+ICAgIAl9Cj4+Pj4gICAgCj4+Pj4gICAgCS8qIEhhbmRsZSBpcyBpbXBv
cnRlZCBkbWEtYnVmLCBzbyBjYW5ub3QgYmUgbWlncmF0ZWQgdG8gVlJBTSBmb3Igc2Nhbm91dCAq
Lwo+Pj4+IC0JaWYgKG9iai0+aW1wb3J0X2F0dGFjaCkgewo+Pj4+ICsJYm8gPSBnZW1fdG9fYW1k
Z3B1X2JvKG9iaik7Cj4+PiBJcyBpdCBwb3NzaWJsZSB0aGF0IHRoZSBibyBjYW4gYmUgTlVMTCA/
IEkgbWVhbiBkbyB3ZSBuZWVkIGEgTlVMTCBjaGVjayBoZXJlID8KPiBUaGlzIG9uZSA6KQoKTm8s
IHRoaXMgaXMganVzdCBhIHR5cGUgY2FzdC4KCkNocmlzdGlhbi4KCj4KPiAtIFNoYXNoYW5rCj4K
Pj4+PiArCWRvbWFpbnMgPSBhbWRncHVfZGlzcGxheV9zdXBwb3J0ZWRfZG9tYWlucyhkcm1fdG9f
YWRldihkZXYpLCBiby0+ZmxhZ3MpOwo+Pj4+ICsJaWYgKG9iai0+aW1wb3J0X2F0dGFjaCAmJiAh
KGRvbWFpbnMgJiBBTURHUFVfR0VNX0RPTUFJTl9HVFQpKSB7Cj4+Pj4gICAgCQlkcm1fZGJnX2tt
cyhkZXYsICJDYW5ub3QgY3JlYXRlIGZyYW1lYnVmZmVyIGZyb20gaW1wb3J0ZWQgZG1hX2J1Zlxu
Iik7Cj4+Pj4gICAgCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKPj4+PiAgICAJfQo+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPj4+PiBpbmRleCA1Njg1
NGEzZWUxOWMuLjBiZDIyZWQxZGFjZiAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPj4+PiBAQCAtOTAwLDcgKzkwMCw3IEBAIGludCBhbWRn
cHVfYm9fcGluX3Jlc3RyaWN0ZWQoc3RydWN0IGFtZGdwdV9ibyAqYm8sIHUzMiBkb21haW4sCj4+
Pj4gICAgCQlyZXR1cm4gLUVJTlZBTDsKPj4+PiAgICAKPj4+PiAgICAJLyogQSBzaGFyZWQgYm8g
Y2Fubm90IGJlIG1pZ3JhdGVkIHRvIFZSQU0gKi8KPj4+PiAtCWlmIChiby0+cHJpbWVfc2hhcmVk
X2NvdW50KSB7Cj4+Pj4gKwlpZiAoYm8tPnByaW1lX3NoYXJlZF9jb3VudCB8fCBiby0+dGJvLmJh
c2UuaW1wb3J0X2F0dGFjaCkgewo+Pj4gV2l0aCB0aGUgYWJvdmUgY29uY2VybnMgYWRkcmVzc2Vk
IChvciByZWFzb25lZCA6KSksIHBsZWFzZSBmZWVsIGZyZWUgdG8gdXNlOgo+Pj4KPj4+IFJldmll
d2VkLWJ5OiBTaGFzaGFuayBTaGFybWEgPHNoYXNoYW5rLnNoYXJtYUBhbWQuY29tPgo+Pj4KPj4+
IC0gU2hhc2hhbmsKPj4+Cj4+Pj4gICAgCQlpZiAoZG9tYWluICYgQU1ER1BVX0dFTV9ET01BSU5f
R1RUKQo+Pj4+ICAgIAkJCWRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsKPj4+PiAgICAJ
CWVsc2UKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
