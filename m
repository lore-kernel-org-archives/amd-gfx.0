Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C22C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 16:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121F164E09
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 16:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121F164E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8308D6E40F;
	Fri, 26 Feb 2021 16:28:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2CC46E40F
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 16:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gw/8mY0QJQXxk7Iz4HLQdobnuN9dUGIMAzdxcwt1+pfFIEf+n11mEvXmRuWgyNvfrC6itUWNnEw9J6HvcY9oebAY5NTluQbmvTgk5W5dskZilKEX9ChawmU26Ds0lFnKHixm/hI0NicWqFemjMbpnNYoXCWpVaMmEDSuSLivEajJBLm2idFya2RNMKgluNn/f7IwqQVcUMmbY6U7V/uXetVLiVorX6N6biKR8kMEJXNBhNEO3AtlQmkb54fflkV7ak327UPjS+ol/GBMOXA/t/zTbHLeIm5zfCiV/m5YTofknrLn9iHLLxe2xrGoN5KlMxQiG7yV+MIr98D0Dirxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSTSfWqQHJi3kB2b4FRR//4ymSdTq9Cmj+3wgph9rio=;
 b=nT9aMqVS4yS3vLs0bWTvTk+CrdKi+vAJxdJlPKj7dRvETCMjvBg61zMIGBwXYh7KsuMAy4NXPfrKz90mCanj1WwWfxC0gdIi8yVA5VdNzHN/HOhGCP5DbWwdtAmBzevRHtdplU+rVRlIO7ETJwd8jFqBToBGzpPi34nISIqaDcY7rwOf1FJ2e7Op0K1N6fQcTPU+t3szCor+SDVSwhgKHt20ysKTD/216EpwK3N3RodkRpNhaJrSMOiCg70EtPv3OXlwqATW5Td+DWUsVHxgVi64/N1aZ4zdb31PCqkpvY2TvAcNNMoNTEfDEuNhemkv0V0WLLOKyKmNyYTCutqgzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSTSfWqQHJi3kB2b4FRR//4ymSdTq9Cmj+3wgph9rio=;
 b=1bqgLzOCMKRoeWSrqWf+NW2jzyqLKYjdQxe1/Ds16inJaFo1frB7tHDatvpSrXGpOl3mIs111CCh60sOm4pok+ZBN2yNs5PCPLXidjqs+UnqitHszMsZN+EpRfIH/wrsSkRhcWJv6pIGQ2rK2y+f3Q1PAcyy/eGdKaeRXQfLAuY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Fri, 26 Feb
 2021 16:27:57 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3784.030; Fri, 26 Feb 2021
 16:27:57 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: Make noretry the default on Aldebaran
From: Felix Kuehling <felix.kuehling@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210225185602.661486-1-alexander.deucher@amd.com>
 <20210225185602.661486-2-alexander.deucher@amd.com>
 <c314c5ab-7e29-0c42-ebcb-ac32e6cf41b7@amd.com>
Message-ID: <00e673a8-50f6-8b49-1a05-9dcb543f3c60@amd.com>
Date: Fri, 26 Feb 2021 11:27:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <c314c5ab-7e29-0c42-ebcb-ac32e6cf41b7@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::44) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.32 via Frontend Transport; Fri, 26 Feb 2021 16:27:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d4952d3-4316-4f74-c4ab-08d8da7379e8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40488668FF14612DCB2981AB929D9@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09rhM2cCh8uLFtrVeWIPkUW3pToMiXfF8iMR4Y9JG7bErgNPAlRRTtXkeN+7jYB7neE7flD1Z15+eI1nKTZZU2yRJC7wVj8SqxFRDoa9573NEkKM9FQkOvbzYuWOO+0Wybzm2cbfjGHqJOoLuGhpmQBySrb7/arkj/8BOp1LKGzMX/OJLMrzPg9AjJEnHvFJ7/GichIaw3SK05vl3nm0fxuVyXN2+fNHHUbHt2ZrguYjG7sJ7F5DPSfqf25+SgLhBkm4hDcqUqc5Yc/b1f4p7i689Bmk8z9CdYxilfRvR6f0gudUy+BL5FM0+MsGNF3PXlYg2AQt/VLblvM9eNgPPY7it8Kx83x8kp2YPveCc4p3+Mz1knj/WBXvR0jR/NlzpDWIUT56Yf1NHYjuyZbNtHjVPBeX2a+fmARfDvl+YGhOUX7xkaW/zlrMcm5bC5Rro6BvpvH/C2nN/YIIGsW3Ui3Ey8UVMVbz87iaXyVdVmZMStsaV8hnEoUXHx2ZsWavPG8oD+5YJ487goRayuMQdgcJPKFHr5Wmc7FH/R0OB9jR/8ZDZB4GJhLCnYAWgey1/aHY84dBcsVI0sw18oUPXIZUbfheS8Lztni2d8eFt5FgUjWB6I1GLAI2IiAYQL19jK573fpegwK4Orn5Fa0JFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(2906002)(16526019)(4326008)(26005)(5660300002)(54906003)(966005)(2616005)(186003)(36756003)(8936002)(16576012)(956004)(8676002)(66946007)(44832011)(66556008)(66476007)(31696002)(31686004)(316002)(86362001)(478600001)(52116002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TUI1TG5hS3JQN2pxajRWSndHcWM2amJFaHVsb3I1WEo4Q0dCUFpPbUNXNzRH?=
 =?utf-8?B?OXB0Tm45bFRRRmljUjlOQXJQNElVQS9wMkRTYUJ2OGJoU1hEcHJJNjZsd1J6?=
 =?utf-8?B?Y2wraGltVndXZlZ6T2RTbmRVQTNtT0NHaUoyMTdqY09IdmUxK1NKWENscXBq?=
 =?utf-8?B?bTEvQnNPTW94alpoRDBkREQ5UXNQWk1uU3o1TC9hMnpocWpCVkw1N0RrOHF1?=
 =?utf-8?B?QVRqc2ZsRCtQUEw2eU9OSVJ6YVFTK1N3TGpqMm9ndWVyNCtDbWtQZzJYbUth?=
 =?utf-8?B?S2JoMG9BcldXT1VjS3VGOXNOU0crYm0zeHhaQitHN0tWN0NoUHNSU3J2SG5K?=
 =?utf-8?B?OVNVNXhTR00xVGU3QkRVSXBDVXBOazA2MEN2ZDI0Z1NpSUNHWVF4K3NESFJr?=
 =?utf-8?B?cjR5VjhFN2hZNDRNdlJRMUxNK24vU3JHN01CZzg1U2ZxUXl6U2tWREJZTTBv?=
 =?utf-8?B?Qk11R0NET3RBWFNieW44ejArdTMyd0lUd1BIakZvdE1mUW44aUlRYzl1SDFY?=
 =?utf-8?B?dTdWQlpEVmlKaG1jK0RHbWlpUUxxQjQvZWRRVGZqbUpuUkZZRWtMTnl4ZXIw?=
 =?utf-8?B?RDdYS3hMZURaT1FSeU83VUVPcm1TOXo5Z1dackFIbytVTUwzMUlEdFIyUXBw?=
 =?utf-8?B?TVprYUJXcVJ0d05RWDUyaUh1U1pyajVBa0QyeW1HNE1jSFFKemVaVTRZeHJh?=
 =?utf-8?B?QmdtSndjMjJZZFAzUmZDSnk3N1p1UmlFNUoyTTZ2Yy9XOVo1aXNFLzlDUnNs?=
 =?utf-8?B?QlJrQXN4bDRjRDJVTWU4ZzZ4SVpwSHA4YzZIZURwZmV2aExlc2NHNlhCbDRu?=
 =?utf-8?B?UkZVVi9LWEVLMkhFSjJsOXE5ZnlLS09rVDYzSnA2R2YzK01FNG9kSWlUNWg5?=
 =?utf-8?B?RlZ1SGpYanBsT1ZTWW1lRjdaQ2k5a0pWeE0vYW9CV3llcXRtbDk0YXlLaFAv?=
 =?utf-8?B?azM1R0ttMkYrV3Q4UUs4UmdqVmtYVVIzRldML0g5Z1YzV3daSHV5bzVSVmky?=
 =?utf-8?B?QWxxOGxZN1lZdWZqSnJ4YkN4SENRWnh6UlU3ZVJQMGxrZytOL29JK0tGZjA2?=
 =?utf-8?B?TCswaE9VSDA2d3FzdGZITXRsa0QrS3FvWlMvLzQycFY4aWVUZ3d3YXZ3WS85?=
 =?utf-8?B?V1VoKzdqbG9uYmJvRU1DRitYc3RJT2hTSzd4Q3p6RE5vRVh5OE54bXZLc0Yy?=
 =?utf-8?B?SW0yeUVUekU1a1JUQ3pjdlRsSEVxSkpvZVZDbW9oSHZtZTZNcGNiTzdYSGJK?=
 =?utf-8?B?R3Z0NHJwNG5GYnQyY05rWWMrSC94dWU0N0NiZ1dzT2hIakgyeUwxRTVBZEZo?=
 =?utf-8?B?RlRCdmljT0FQR3ZJRm9Da0krdm9ERlVLclJUM1FaREJIR0lhZ1QweFdPM1NZ?=
 =?utf-8?B?ZytkMmtDSFkzYTdzR05JU3lHSSs0enZEcnlIUTgwZUk2S3Y1YkhrL3JoTDBi?=
 =?utf-8?B?Vk1KM2s1K3UrZW5WMWVQTVFCQmpkWkNkYXJucUYxWGVMbnJVWVlXN1VlWXhy?=
 =?utf-8?B?bFEraU5TS3d5MHlkdHRXU2Q0TnM2S0VYU2g2OHpGT3ZEUzNqRzdMMDRtcHV4?=
 =?utf-8?B?NnFXUXVXUHhxMDRObmRYR28ycTIybHdtK2MxM1ZpbEttUXVKNzNtTldqem9x?=
 =?utf-8?B?NS96U3RKL1BqUWFkaGVoT3FDanFGL0dlN2UvZkNCSWhnWndFRzVxR1JmREVp?=
 =?utf-8?B?SFI2dFYxMzYvbUQrdXk3bmNMaG1mSE5idnpMaG4zNElLMG5CNG9zbWhycjJz?=
 =?utf-8?B?SVpTRkJYNkVmc2tGbGZLbzBvRmJwYjdkdWFBeHVxTzRRbG5VUnZFVGtKWFEr?=
 =?utf-8?B?VnZVbFAwaEFPMFJYNTcwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4952d3-4316-4f74-c4ab-08d8da7379e8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 16:27:57.5422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 234vOmDNsbQb1v0b/dtz9EsDHJhELRwV+kFNvFklB0ro3jYHlMKopKAlpI4yDIU7Rc2QnoNNPkWQcHQfspMJHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TmV2ZXIgbWluZC4gVGhvc2UgcHJldmlvdXMgcGF0Y2hlcyBhcmUgcGFydCBvZiB0aGUgSE1NIHdv
cmssIHdoaWNoCmhhc24ndCBiZWVuIG1lcmdlZCB5ZXQuCgpUaGlzLXBhdGNoIGlzIGdvb2Qgb24g
aXRzIG93biBmb3IgYW1kLXN0YWdpbmctZHJtLW5leHQuCgpUaGFua3MsCsKgIEZlbGl4CgpBbSAy
MDIxLTAyLTI2IHVtIDExOjI0IGEubS4gc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBUaGlzIGRl
cGVuZHMgb24gdHdvIHByZXZpb3VzIHBhdGNoZXM6Cj4KPiAyZTQ2NGE3ZmI4ODMgZHJtL2FtZGdw
dTogRW5hYmxlIHJldHJ5IGZhdWx0cyB1bmNvbmRpdGlvbmFsbHkgb24gQWxkZWJhcmFuCj4gNjI4
YzhkM2ExNjAyIGRybS9hbWRncHU6IFJldHJ5IGZhdWx0IGhhbmRsaW5nIGJhc2VkIG9uIHBlci1w
cm9jZXNzIFhOQUNLCj4gbW9kZQo+Cj4gUmVnYXJkcywKPiDCoCBGZWxpeAo+Cj4gQW0gMjAyMS0w
Mi0yNSB1bSAxOjU2IHAubS4gc2NocmllYiBBbGV4IERldWNoZXI6Cj4+IEZyb206IEZlbGl4IEt1
ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+Pgo+PiBUaGlzIGlzIG5lZWRlZCBmb3Ig
YmVzdCBtYWNoaW5lIGxlYXJuaW5nIHBlcmZvcm1hbmNlLiBYTkFDSyBjYW4gc3RpbGwKPj4gYmUg
ZW5hYmxlZCBwZXItcHJvY2VzcyBpZiBuZWVkZWQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEZlbGl4
IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+PiBSZXZpZXdlZC1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+PiBSZXZpZXdlZC1ieTogUGhpbGlw
IFlhbmcgPFBoaWxpcC5ZYW5nQGFtZC5jb20+Cj4+IFRlc3RlZC1ieTogQWxleCBTaWVycmEgPGFs
ZXguc2llcnJhQGFtZC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ21jLmMgfCAxICsKPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+
Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jCj4+IGluZGV4IDZkOWM2
NjBkYTI3YS4uOGE2NGY1ZTQ5Y2IyIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ21jLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dtYy5jCj4+IEBAIC01MDgsNiArNTA4LDcgQEAgdm9pZCBhbWRncHVfZ21jX25vcmV0
cnlfc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+PiAgCXN3aXRjaCAoYWRldi0+YXNp
Y190eXBlKSB7Cj4+ICAJY2FzZSBDSElQX1ZFR0ExMDoKPj4gIAljYXNlIENISVBfVkVHQTIwOgo+
PiArCWNhc2UgQ0hJUF9BTERFQkFSQU46Cj4+ICAJCS8qCj4+ICAJCSAqIG5vcmV0cnkgPSAwIHdp
bGwgY2F1c2Uga2ZkIHBhZ2UgZmF1bHQgdGVzdHMgZmFpbAo+PiAgCQkgKiBmb3Igc29tZSBBU0lD
cywgc28gc2V0IGRlZmF1bHQgdG8gMSBmb3IgdGhlc2UgQVNJQ3MuCj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
