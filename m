Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE896C07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 16:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F44E60FF4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 16:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F44E60FF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 567466E3F4;
	Wed, 14 Jul 2021 16:04:27 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E1586E3F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 16:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQDdvQnBDdUskthWrzcbylNMM6PNGGKpKoSybuyJAtmq6tNX9tuq5MW3nFul114DBMxL47mjXrGIvGGWdjTg3CSkKzKIcTYNDNhBDfQ/pDUJSUS20L2JA5gFuMrauFVPTD0Rt9wEvDDFR7jVoY1H1gGPYIxBUfWIh9VgGhKpbvOc2ruNKojrRYT7k1mUGoxaqyrkB3zOJAjkMWJ9R8sTc1d8cgnek1cJ6cBc9ON9xyJYAqA2G8H0h81FnxaoJF2F1ZduY5ZrN/R3uixiP1mYdC12Sfg72tjrs43tKp5TaqPMDirpkerpA1UAAY6R4WopHYOyHMMhkz5o/JbYVz7b5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZSJXZvlIpd87E4nR7l9aTym5FyOFLfi6piUPVv6NkY=;
 b=n93IQTXQYUGAATngC6JpXjOQ4xvwf8qmOXnAFH67ow4OQgo3prNJq69VSjZ2nGRWEoxBFyvfUTmoMd6/rJKzDmJB0fAYZBY/QZXjn4j9M66E6ZqGIGgkCL4Hkn0hWkf1SknKjCVqu694F8sLeyxs1vriI5A+2yqM9FmLcmvpNCODQGAS/kYKS1kASpzYWVRufvZmBw3JsWRTO+e0c9DvSarFapo2a7WsLNMyU8zzBBrseaXOA64VtzhQ8Dql7lewFyK0On+EKRg2f5duGyj7QEZ+FXoxiye/Q+IH68ZpC5xAz8h3/MCMYS24ZN/BzkIKZXaZF22vNX/2jPMF/hJOmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZSJXZvlIpd87E4nR7l9aTym5FyOFLfi6piUPVv6NkY=;
 b=WlKrWMgtWm5dLbrEOZRiPtbU09YnE9H5YejFnKdEz5CoYD8tpheC6nH0sMXpDFgaAzg7SqpEsgPAyVfJpkYPahMKr1Y15Mgt3eBf/f4WgYdfTNFT/IcEmJAzanLXLuj8nUnJGWMX9hM8XiHL8ms9sK11PRx6igLYS+VpSZU62Mg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 16:04:23 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 16:04:23 +0000
Subject: Re: [PATCH 1/3] drm/amdkfd: Disallow debugfs to hang hws when GPU is
 resetting
To: Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1626276343-3552-1-git-send-email-Oak.Zeng@amd.com>
 <1626276343-3552-2-git-send-email-Oak.Zeng@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <705cea8d-fd6a-ba84-60a9-d6b8749131b5@amd.com>
Date: Wed, 14 Jul 2021 12:04:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <1626276343-3552-2-git-send-email-Oak.Zeng@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Wed, 14 Jul 2021 16:04:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62c6ed64-03fd-4a8f-572f-08d946e10bde
X-MS-TrafficTypeDiagnostic: BN9PR12MB5324:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5324EE08971E2DFDAA09BBEB92139@BN9PR12MB5324.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5962OnlZDGwn3yJPVSncy0KSoAd5ZAoNsILtY3SJwHDaZcT+3C2Hja7u0eGsw+sydOg4SBt18g+Sm1bqPJbtrx2ZXkYM0vFwSR7XqdKkZeDDER/dtPGTb/FFVMm7H3K6U77PskRJ0vauHw1ao6e4zDOwKgSTap08SIoW9I6T4QlocH2yo5WYAlTY8ef1wFJMVCwN8feuAq336T8yTycdS0j88v5/rSuhqIdLpLmh4YbGYQhGZFC3a/gNK7VbvJy7grYtdQjjh74rW1X0LfXhg3fGU6rrnW7ecBpEt2tBqkHIE1S+XXf7rzPAq/gcxIPQz5C+BP4lNHOURePj6ZYPqVy8CNP7A6gPndHe4h2Ie/Rej4lRWxrf3MVBX/XhhXBKhzB4ujGSRg4zVMDgr0KhQtsuerJYNxBL9LDwQQrtGdUyystPfctB+Go3fRRM90dT/lNep9OFWcNMeozhCZR6CgPORJOsZnmkoyqmRCX9t7wVPuZkbzRCR43lfES5iNKsZYprfXjbTseMqxQjPWL8rm5ID0Sp4FlcuzFATr01N1VV8SfITmdIrQi1QvgYq8wOwehbYRxXtJF1L5d13E/Xw8v+9hCHQaR/T1p/ANdu77PfqM8/Ez3ARgdNh07ZGVmjwrwD0zrh/VwHkQiDcwDLT0GuJzXE29BSqK6ThIL3+gpGQ262PGhWjevSIw26U3GWAwsKDqY/BOh8qfOTWTr0rabtesyXA8KJt/IXRZfXXI5uf2blsUzKuQrO3i0cW2TJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(36756003)(16576012)(316002)(86362001)(2906002)(2616005)(956004)(44832011)(83380400001)(186003)(66946007)(8936002)(66556008)(66476007)(8676002)(26005)(6486002)(38100700002)(4326008)(31686004)(5660300002)(31696002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SStXbzVqNXBVdWNMZi82c0RWbEF3VGhyMWtkcEVXNUFJbExlKzVZZHU0RktO?=
 =?utf-8?B?Z3RTSUdtNTJ2YUw5V3hKNFljN3BQcnVYNXZ3c3ZLdW9ZeGphK3Z2VzBIT3JY?=
 =?utf-8?B?NnhVZW1SN3JXeVF3cjRzN2pkUldBczk3ZDNDbWtlQWlCR1pUMm5kRHJDeTVB?=
 =?utf-8?B?aU1SS2RnUHJtVWtUVU1zN3VYWW9LY21SS1ptZ2wzcktHN1NtWlBLTVZPUVlh?=
 =?utf-8?B?NDdSK1hIbVdYVWdseEdkaXpTUmNMZEh5cG9adDdZbFFqaHdrT3lLeU9YVGFV?=
 =?utf-8?B?UU5KNGVpVUUrYzNCWTY1QW1sRko4ckxzNE9IS0NIaWpoY2RaSTVpbG40R2xR?=
 =?utf-8?B?dm1OQnVRN3plQ3lxcEFsVzlTTlFEZ3NCWVZIWGFSZ3NQSlFkcWphUUZwTXBQ?=
 =?utf-8?B?ZXhERjROUFhNMzhQdVM0ZHFDUTBjMUFiNXRWaEp5c2ltelh5dGRuSEZwOVpP?=
 =?utf-8?B?TTNKdktrQVNDOXFiUU9WeFVNM1ZjRTlBM2VOUHBWNmFKbUhnOUU4bk0reXJn?=
 =?utf-8?B?emk0eGNlT0RFWG1Cd3pXN0l3aS8zZ2ZkUi9raWx0Y1dweWkwSXpsV2hqZjgw?=
 =?utf-8?B?REV4V0Z3RDhSMzZ5Y0t2OGJncTFveFJlUG5BT3JCN0FhbW9NeHV1cDJldm81?=
 =?utf-8?B?d28rL20xR1dqVm5EWnJwdUtDc3NQbFY2QTdUbFgwY0kza0tFaC9uSGhhV3dE?=
 =?utf-8?B?WVQ4K1Y4WjRZMmdFcTZWZ1Q5ME5vUkI1ZXZEd2k4RXdkS2ZJczdTaUtQam9C?=
 =?utf-8?B?QkpuamVUQkxJQ1pZTXVFSk5qR04weS9vUlQ3QkpxWmFHYVowUmtDckRZNlB4?=
 =?utf-8?B?MU1KNDUrMG0wYklQb0JDYXRWL2p2UEQyYWdOa0NCVVJ1c3RMQk81eWhUU0xO?=
 =?utf-8?B?eE9PMThTekFEN1JHRXVSMjdUbldocHE5UmM0VUh0T2JHbVM2SWNKY2dtSloz?=
 =?utf-8?B?NUo4T2lkMjRZZ1Q2a0ljZ3JMdVMxNjhvdEJ5d0E4WFM3ajFNSmVyNnJ0WjhE?=
 =?utf-8?B?bFpZMGM0YU5CczdkZEFSZGIzSVlBdXF4U2VKQkRLaXI4NEk0anVDMGRDN1Rr?=
 =?utf-8?B?V0xlMUl4WG1OTkxUcUlSL2dCcnhSRzlFdWZKVllRVzNIWVVWdERicnFFRXRE?=
 =?utf-8?B?QjRnL3k0NisyY0U0WmxiSkV1Ym92dFJ0aGJpdmt1MFA1ZkJtQ0R3cmpWaVhH?=
 =?utf-8?B?QkY0VmVFRWcvWjdtWmdPVldudm5PUGNjZmhxdEJGRHVsWTZuZG9Ya1QvS0ov?=
 =?utf-8?B?WVE4OGtNbVVIMkMxRlBnNGpyTUlUKzIwQTZoTWlYdkdPc3JxQmZVOTNxZGRS?=
 =?utf-8?B?M0krTndGbXIvWXQ2eHpQOTdBektkTFBDMVVUNXRUdFFYa3I1eDlGSk82eFlC?=
 =?utf-8?B?UE94VlpBM09oWkozNHhJT0IzenhNaHl0R0VkRTdPNzdidGZaTzkwK0NXUFdn?=
 =?utf-8?B?T1FJbk84NWorQ0RGTlZjWnBwNjZnSStUaG85VUpKOGowbEJ2RmhUbmZ1anAv?=
 =?utf-8?B?QzFOL1NneDVxMGpUcUR5SjczTUxIbnlLdW04UDJrakRnSGpWeHFnNWUrSWlK?=
 =?utf-8?B?S2dTTTJTQ3Qrdmo2UDA4dm9FZkdWakR3aEtRb2tGT1FBZEhpUEU3QWNsSzRS?=
 =?utf-8?B?ZEM4M2x2TU5DT1BhUCtDMUdsUTBDRlZWYWo3NUNLSFp6bXRIL1MvRHpZMWxh?=
 =?utf-8?B?ZTA4SmhGTEVDSWU5MG1yeFNaMUNQNjVsZ2d5endIS3ZsdGJNK1JsWHpDamlI?=
 =?utf-8?Q?zIqGg8VrzsmBcsZRWSBr1NfzoFs2t9NMOnAtCAB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c6ed64-03fd-4a8f-572f-08d946e10bde
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 16:04:23.1995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iFdgJZs5QVA+hXRehU/hRuy2drOueDURzfqwrJpbYCuhANujXvev9x4n9tQ4EwINium9pEHjJ336FCvapdOwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5324
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
Cc: feifei.xu@amd.com, leo.liu@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNy0xNCB1bSAxMToyNSBhLm0uIHNjaHJpZWIgT2FrIFplbmc6Cj4gSWYgR1BVIGlz
IGR1cmluZyBhIHJlc2V0dGluZyBjeWNsZSwgd3JpdGluZyB0byBHUFUgY2FuIGNhdXNlCj4gdW5w
cmVkaWN0YWJsZSBwcm90ZWN0aW9uIGZhdWx0LCBzZWUgYmVsb3cgY2FsbCB0cmFjZS4gRGlzYWxs
b3cgdXNpbmcga2ZkIGRlYnVnZnMKPiBoYW5nX2h3cyB0byBoYW5nIGh3cyBpZiBHUFUgaXMgcmVz
ZXR0aW5nLgo+Cj4gWzEyODA4LjIzNDExNF0gZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0OiAwMDAw
IFsjMV0gU01QIE5PUFRJCj4gWzEyODA4LjIzNDExOV0gQ1BVOiAxMyBQSUQ6IDYzMzQgQ29tbTog
dGVlIFRhaW50ZWQ6IEcgICAgICAgICAgIE9FCj4gNS40LjAtNzctZ2VuZXJpYyAjODYtVWJ1bnR1
Cj4gWzEyODA4LjIzNDEyMV0gSGFyZHdhcmUgbmFtZTogQVNVUyBTeXN0ZW0gUHJvZHVjdCBOYW1l
L1BybyBXUyBXUlg4MEUtU0FHRSBTRQo+IFdJRkksIEJJT1MgMDIxMSAxMS8yNy8yMDIwCj4gWzEy
ODA4LjIzNDIyMF0gUklQOiAwMDEwOmtxX3N1Ym1pdF9wYWNrZXQrMHhkLzB4NTAgW2FtZGdwdV0K
PiBbMTI4MDguMjM0MjIyXSBDb2RlOiA4YiA0NSBkMCA0OCBjNyAwMCAwMCAwMCAwMCAwMCBiOCBm
NCBmZiBmZiBmZiBlYiBkZiA2NiA2Ngo+IDJlIDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIDkwIDBm
IDFmIDQ0IDAwIDAwIDU1IDQ4IDhiIDE3IDQ4IDhiIDQ3IDQ4IDw0OD4gOGIgNTIKPiAwOCA0OCA4
OSBlNSA4MyA3YSAyMCAwOCA3NCAxNCA4YiA3NyAyMCA4OSAzMCA0OCA4YiA0NyAxMAo+IFsxMjgw
OC4yMzQyMjRdIFJTUDogMDAxODpmZmZmYjBiZjQ5NTRiZGMwIEVGTEFHUzogMDAwMTAyMTYKPiBb
MTI4MDguMjM0MjI2XSBSQVg6IGZmZmZiMGJmNGExYTVhMDAgUkJYOiBmZmZmOTkzMDI4OTVjMGM4
IFJDWDoKPiAwMDAwMDAwMDAwMDAwMDAwCj4gWzEyODA4LjIzNDIyN10gUkRYOiBjMzE1NmQ0M2Qz
YTA0OTQ5IFJTSTogMDAwMDAwMDAwMDAwMDA1NSBSREk6Cj4gZmZmZjk5MzAyNTg0YzMwMAo+IFsx
MjgwOC4yMzQyMjhdIFJCUDogZmZmZmIwYmY0OTU0YmRmOCBSMDg6IDAwMDAwMDAwMDAwMDA1NDMg
UjA5Ogo+IGZmZmZiMGJmNGExYTQyMzAKPiBbMTI4MDguMjM0MjI5XSBSMTA6IDAwMDAwMDAwMDAw
MDAwMGEgUjExOiBmMDAwMDAwMDAwMDAwMDAwIFIxMjoKPiAwMDAwMDAwMDAwMDAwMDAwCj4gWzEy
ODA4LjIzNDIzMF0gUjEzOiBmZmZmOTkzMDI4OTVjMGQ4IFIxNDogMDAwMDdmZmViYjNkMThmMCBS
MTU6Cj4gMDAwMDAwMDAwMDAwMDAwNQo+IFsxMjgwOC4yMzQyMzJdIEZTOiAgMDAwMDdmMGQ4MjJl
ZjU4MCgwMDAwKSBHUzpmZmZmOTkzMDdkMzQwMDAwKDAwMDApCj4ga25sR1M6MDAwMDAwMDAwMDAw
MDAwMAo+IFsxMjgwOC4yMzQyMzNdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAw
MDAwMDAwODAwNTAwMzMKPiBbMTI4MDguMjM0MjM0XSBDUjI6IDAwMDA3ZmZlYmIzZDE5MDggQ1Iz
OiAwMDAwMDAxZWZlMWVjMDAwIENSNDoKPiAwMDAwMDAwMDAwMzQwZWUwCj4gWzEyODA4LjIzNDIz
NV0gQ2FsbCBUcmFjZToKPiBbMTI4MDguMjM0MzI0XSAgPyBwbV9kZWJ1Z2ZzX2hhbmdfaHdzKzB4
NzEvMHhkMCBbYW1kZ3B1XQo+IFsxMjgwOC4yMzQ0MDhdICBrZmRfZGVidWdmc19oYW5nX2h3cysw
eDJlLzB4NTAgW2FtZGdwdV0KPiBbMTI4MDguMjM0NDk0XSAga2ZkX2RlYnVnZnNfaGFuZ19od3Nf
d3JpdGUrMHhiNi8weGMwIFthbWRncHVdCj4gWzEyODA4LjIzNDQ5OV0gIGZ1bGxfcHJveHlfd3Jp
dGUrMHg1Yy8weDkwCj4gWzEyODA4LjIzNDUwMl0gIF9fdmZzX3dyaXRlKzB4MWIvMHg0MAo+IFsx
MjgwOC4yMzQ1MDRdICB2ZnNfd3JpdGUrMHhiOS8weDFhMAo+IFsxMjgwOC4yMzQ1MDZdICBrc3lz
X3dyaXRlKzB4NjcvMHhlMAo+IFsxMjgwOC4yMzQ1MDhdICBfX3g2NF9zeXNfd3JpdGUrMHgxYS8w
eDIwCj4gWzEyODA4LjIzNDUxMV0gIGRvX3N5c2NhbGxfNjQrMHg1Ny8weDE5MAo+IFsxMjgwOC4y
MzQ1MTRdICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5Cj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBPYWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jIHwgNSArKysrKwo+ICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rldmlj
ZS5jCj4gaW5kZXggOWU0YTA1ZS4uZmM3N2QwMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfZGV2aWNlLmMKPiBAQCAtMTM5MCw2ICsxMzkwLDExIEBAIGludCBrZmRfZGVidWdm
c19oYW5nX2h3cyhzdHJ1Y3Qga2ZkX2RldiAqZGV2KQo+ICAJCXJldHVybiAtRUlOVkFMOwo+ICAJ
fQo+ICAKPiArCWlmIChkZXYtPmRxbS0+aXNfcmVzZXR0aW5nKSB7CgpDaGVja2luZyBkZXYtPmRx
bS0+aXNfcmVzZXR0aW5nIHdpdGhvdXQgaG9sZGluZyB0aGUgZHFtX2xvY2sgaXMKaW5jb3JyZWN0
LiBUaGUgcHJvYmxlbSBpcyBub3QgcmVhbGx5IHRoZSBmYWN0LCB0aGF0IGl0J3MgcmVzZXR0aW5n
LCBidXQKdGhhdCBkcW0tPnBhY2tldHMgKHRoZSBwYWNrZXQgbWFuYWdlcikgaXMgbm90IGluaXRp
YWxpemVkIGF0IHRoYXQgdGltZS4KCkEgbW9yZSBnZW5lcmFsIHNvbHV0aW9uIHdvdWxkIGJlIHRv
IG1vdmUgdGhlIHBtX2RlYnVnZnNfaGFuZ19od3MgY2FsbAppbnRvIGRxbV9kZWJ1Z2ZzX2V4ZWN1
dGVfcXVldWVzLCB3aGljaCBkb2VzIHRha2UgdGhlIGRxbV9sb2NrLCBhbmQgYWRkIGEKY2hlY2sg
Zm9yIGRxbS0+cGFja2V0cyB3aGlsZSBob2xkaW5nIHRoZSBsb2NrLgoKUmVnYXJkcywKwqAgRmVs
aXgKCgo+ICsJCXByX2VycigiSFdTIGlzIGFscmVhZHkgcmVzZXR0aW5nLCBwbGVhc2Ugd2FpdCBm
b3IgdGhlIGN1cnJlbnQgcmVzZXQgdG8gZmluaXNoXG4iKTsKPiArCQlyZXR1cm4gLUVCVVNZOwo+
ICsJfQo+ICsKPiAgCXIgPSBwbV9kZWJ1Z2ZzX2hhbmdfaHdzKCZkZXYtPmRxbS0+cGFja2V0cyk7
Cj4gIAlpZiAoIXIpCj4gIAkJciA9IGRxbV9kZWJ1Z2ZzX2V4ZWN1dGVfcXVldWVzKGRldi0+ZHFt
KTsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
