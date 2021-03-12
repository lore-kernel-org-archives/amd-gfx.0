Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BE3C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 16:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B16864FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 16:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B16864FFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1767689F0B;
	Fri, 12 Mar 2021 16:15:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B11D89F0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 16:15:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RINdz9qaZAhHn6WZeB1A0JtgcDf2+shr/ir2XSixqqTxbpQLeJ10OeX/SDLT9fAzTUIfEgsHYIZU4VjbwpWQjlnnGo5iU+Vdrt6vbVRDB0d+I14TzJVzgb3MXqcDEv8Twk5dD8cslQC5QWvYL+EefVi/8GYhp1+iVpe2N9P5zhwL3Qpx5qGBd63IEKbuQROz3EbCaHCCZXerC/QMV5YQaAyZnscDitaQmlqrCY7S5xPvZVrHv61qGIWj2pasQTJiN580eqBJB/zEnZ7VV/3IGrGAYfrlmTMp945csGBfHjTdlt0hmNW2BQmHyCsnsB11t/jwHCPabWyIwwX1ikZGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxuNZWt9B/Ay/6WZJ3lFq/pGmlamDaXCIZul24icwZk=;
 b=XrFfRrMr+GjTBBLGW9M3J43v4mXeCZKEYpyoTvBUf6MwG8GKeKbB5KMnHmLz9Car2VvRDrjsZ9bR904qvPVY474sLBipS/TeAqNqZRuCuXNm/VkfOaEcHAnh9FZXYyPz9O7RX4XL3bAeeVarbpbF2sbSX16ImGwG95xccmVLBuCfEpEqe3Y0JQQLt5yHM45AGADhhHI9y46i+rAxvb9pDLNdM6YzYn6+Eqh2JPC3D1E1gHIOXg/G9U1Nax+n5bJfIvl5to9iQeKusgghwJgamJMMT8lR3ClyDXeQ+BTPxZ4VNDOPke+G68vu6S/X8Ej+lXOi0A8SktRhaFszVo8Iag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxuNZWt9B/Ay/6WZJ3lFq/pGmlamDaXCIZul24icwZk=;
 b=Hc6jroiXxI44WPrOFScHazkhppuN5BWEI0u39BUSYG0uf7RJ1SL39YQp23WRi1OPo8oEkHaibLtoXzyQ+4wIrYzrOREeaClXfxw73ma/IWZ5tE/3q9BAs2wQelHOcnCxqzUM9URF1PiDJ/jCWqF+5QDCPuGZMo97ZW1jR4mKO8c=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 12 Mar
 2021 16:15:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 16:15:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: David Hildenbrand <david@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Andrew Morton <akpm@linux-foundation.org>, "Liang, Liang (Leo)"
 <Liang.Liang@amd.com>
Subject: RE: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Thread-Topic: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Thread-Index: AdcWgujrowoM8ON/Tmy0Tmhi9senVQABLLQAADBH9CAAADxQgAACUAfQAAEOAgAAANA2IA==
Date: Fri, 12 Mar 2021 16:15:25 +0000
Message-ID: <MN2PR12MB4488C3956E0B99CD360B0A27F76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <MN2PR12MB448872F0BE8F49C78AF908F3F7909@MN2PR12MB4488.namprd12.prod.outlook.com>
 <2f7c20ea-888f-65b6-6607-c86aab65acce@redhat.com>
 <MN2PR12MB44886034D18F900F4FE45D8DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <15faeb97-d031-f70a-adab-f2966e0b1221@redhat.com>
 <MN2PR12MB44884289499B6B16A0E9017DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <b5faa9b9-6f40-f8e4-cf7c-795b429e02a8@redhat.com>
In-Reply-To: <b5faa9b9-6f40-f8e4-cf7c-795b429e02a8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-12T16:15:22Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e7c7ada3-0af5-4a9f-81aa-122fe58df066;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 993ed946-eaf4-4ab9-f4c6-08d8e5720b64
x-ms-traffictypediagnostic: MN2PR12MB4487:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB448746BDAF519620F3CA4493F76F9@MN2PR12MB4487.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dZoPlXUURRTXSx36rokiLWQbx19KYgVeW7D2cUA9N86bV6+cV0/Er1YL+aBgdDW4U/4k64gD5xgJONlSQDFyQVbs1koUUeEYAGZQwSml0kmnoo+JPNdrjcb9jEAdPLLsxzDsHDJBOjxK68JVa6+0geRmKsUFQv5/xcJxk9nquQg4pX+I3PLbMlWcVfRB04pSHSSkNwq87N/WNssbO5LqqPs4PWVy+Y3n4oU0Q6Pn29tdLjTTTYINkdFNKkjhemwiPjF84D5+LSlrhiM37kWNkJOcqGIooYMKF9l9KpSI5DrI+jodGn1QsD9nFgKumP9rHg2Zso9RaNjs/zJkhIbXMuT4gIwA4q4I7BfMgsfNN1rqsSklsRIJQcB2JgIGeL31Ume5FzxaRfIYxPKo0UuYuSwxPJusyqM2Lir+hgMZgwRJ5mNHkt+v6errWarqLs6ptkcXRLYNGhGSo6+kZUl/dWBgPrNi/+Rz3mWP30p3V5QoLU8c9Ze9tw/U79qrRafPb66yz5KSRT9q5VCEfRkArZ4WYQnt0rxA5BZp/0padPTQmMKX5uuMV2tNIKbuQHZH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(110136005)(316002)(71200400001)(54906003)(33656002)(8676002)(478600001)(8936002)(86362001)(186003)(26005)(6506007)(5660300002)(2906002)(76116006)(6636002)(9686003)(83380400001)(66476007)(55016002)(7696005)(66946007)(66446008)(4326008)(64756008)(66556008)(52536014)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?YmpDWG13ZjUxRno5bjNmVGlkTVc5bDYwWmN1VEx5TzRwSjVydVNkUHRyaEph?=
 =?utf-8?B?TEdCd0pOMW1DTlJCbkF3TVVCMytnRzdsRVlNOUQxZUY3aVdnSFBDYldjNUR3?=
 =?utf-8?B?V0EwRVJ0RnNiZ3pUbm1ZYytsTVpNdGJZaHJ0RzlsY0xjVVQ1UjV5VXZyRVVz?=
 =?utf-8?B?aXJReVhVbkQ4ODNydWhSeENyODRyTjVhMDc3VzFhSVlqRXV0Qy80MkhoM3FG?=
 =?utf-8?B?RkYrSkJqWmNCWC95M3RLMFNiTW8wUmMyK3pLd1R5K2RMYjU2SVNaM2U1ZHFi?=
 =?utf-8?B?ZjV1bmRxd2J3M3ZLTSswdHh4bXU2OTNHR0swZlgrbHV3RXhtVWwzbnMzRUZ3?=
 =?utf-8?B?OHlDZC93MTJBM2sxSFo2UVZ2eTg3eThkc1dPd3NwOTB4TFV5THg1dDFJa0N3?=
 =?utf-8?B?bnM4Vk1pclJXN0NmODFJd2ErMXRaVjkvbVA3M1VUUHJyWElhZXhsN1JxQVhq?=
 =?utf-8?B?ZW0remlwR3lmbS9oclkxWGNPVFY0ME5kVHZORXlBeG9wZ1VaMFZwN1FFU2xZ?=
 =?utf-8?B?NjhvdFJmY2ZDL01sV0ttNnR5c01nVXVNaENicTVxbGpXeXh4WFhoOGU5ZzNp?=
 =?utf-8?B?VHZkSEs3TEhGY0dpbTRDNEczNWdEZUwxY0ZKNmJRZTZBNTVZMXZycXhmQ256?=
 =?utf-8?B?NzFMMS8yMXVLcW04elR6VFZ1Z3RVUHVmMGxJaXR5OEFYRjFXdFRvZ1ppYUZv?=
 =?utf-8?B?d0I1N1Fod2R6blpBcVdKNkU1QTBSRU03UHFHS1hsRmNpTzd5RDZOSGlrRjNK?=
 =?utf-8?B?RWQ5M21yTlY0ZkswV3pKazQ2WFFDZ0Z0emdlYWR6QnZFaElkUVl1Nlpnenlj?=
 =?utf-8?B?WUU2UEcwZm1HOTFST1ZpL0lQbzYxdlBHQkhndnlrWWJiUXpXT0Z1QkdjSVMy?=
 =?utf-8?B?S2pYZ29DWHpyOG9zY0JIK1VJOERYYlcyYXdyM1ZIWERRTjZoUHRiUlppWmY3?=
 =?utf-8?B?cHN6RTQyV2RKcmVUQ2RXOXRnVkhNQU9wYXlkZS9FeEx6UG5CU3JzSE82dkdt?=
 =?utf-8?B?U1ZvVDJOaGtNYlo2aCtpWGN6TVlLdVB4MnhCVDZvR1FvRUFBSmRjcVdvamZV?=
 =?utf-8?B?YzVtQ1dmMkYwVXZJaWp5WmpENHYxRXUzZEY0MUNtK0JXQ2lZRlBSWnFLaE05?=
 =?utf-8?B?KzBYQ2g5OHlndFNSb2RQQWhIanErbjhDdWp4bmY0OEZjYVkyWkwwT0xETkZQ?=
 =?utf-8?B?YnNaZVZoaEFvK0RjbUtuSzRSb0tlZ0lZZHg1bDdFMkdRTUc5R04yRDBIRCsy?=
 =?utf-8?B?SkVWYmd4SDZXRjlUbUhZSVlQcFFobkFST25pVElSc3VGa05uTlpzb2tHV0Jt?=
 =?utf-8?B?VHZjN3pSYUdJREJDZGtQTmFrZjUzVGxnYTdZVDZVcHFleG51NFFMWWpqS0VU?=
 =?utf-8?B?YUZCVDVveVNVN2pDMmUrQVkrUXRrWFRIUFJNZTkyM2xvV0YrcUJicDZMRWp2?=
 =?utf-8?B?OVZiU21md0lrdjc4VjJBTmRXSTRJaDVJTjVDL1orVXEzcFRheTVya2JXQW43?=
 =?utf-8?B?Y0ozbFU2UTBjbnFBay9aZVE3bWo3aGZhdi90SjNVZU4vbWpJZGxDM01FUDZQ?=
 =?utf-8?B?OHNBZ0E0TnNBZzZhcjI5K2VGNVMrYUVFS0hjY0ZRSithVGhNd0ZLS2EzRDI1?=
 =?utf-8?B?VXk4VVdJaHZYLy8wcEhTR3RTUi9JRGx2SGZDNlgvUWw4MEtYT1Z6UUNpVVZi?=
 =?utf-8?B?a2dCNTZ4NmJaRjk0VEltemJXcUZ1N01mL0o2eEFERnQvcDNKMkJ1MFhTOWJn?=
 =?utf-8?Q?BAQ6Gy/CO5G+OBCdNQIcGJBWJ/3io8kZQA4CEGt?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993ed946-eaf4-4ab9-f4c6-08d8e5720b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 16:15:25.1908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqxOh4wu+1cMbZXjjWsmHPys5lC2u0MNc+Arv8uNIrc2XUDOaqoiuaXjourez7WjpQv4DNHphWYtoKMGlGxbOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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
Cc: "Rafael J.
 Wysocki" <rafael@kernel.org>, George Kennedy <george.kennedy@oracle.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

> -----Original Message-----
> From: David Hildenbrand <david@redhat.com>
> Sent: Friday, March 12, 2021 10:48 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; linux-
> kernel@vger.kernel.org; amd-gfx list <amd-gfx@lists.freedesktop.org>;
> Andrew Morton <akpm@linux-foundation.org>; Liang, Liang (Leo)
> <Liang.Liang@amd.com>
> Cc: Huang, Ray <Ray.Huang@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Mike Rapoport <rppt@linux.ibm.com>;
> Rafael J. Wysocki <rafael@kernel.org>; George Kennedy
> <george.kennedy@oracle.com>
> Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to
> tail in __free_pages_core()")
> 
> > 8G (with some carve out for the integrated GPU).
> > [    0.044181] Memory: 6858688K/7200304K available (14345K kernel code,
> 9659K rwdata, 4980K rodata, 2484K init, 12292K bss, 341360K reserved, 0K
> cma-reserved)
> >
> > Nothing particularly special about these systems that I am aware of.  I'll see
> if we can repro this issue on any other platforms, but so far, not one has
> noticed any problems.
> >
> >>
> >> Increasing the boot time from a few seconds to 2-3 minutes does not
> >> smell like some corner case cache effects we might be hitting in this
> >> particular instance - there have been minor reports that it either
> >> slightly increased or slightly decreases initial system performance, but that
> was about it.
> >>
> >> Either, yet another latent BUG (but why? why should memory access
> >> suddenly be that slow? I could only guess that we are now making
> >> sooner use of very slow memory), or there is really something else weird
> going on.
> >
> > Looks like pretty much everything is slower based on the timestamps in the
> dmesg output.  There is a big jump here:
> 
> If we're really dealing with some specific slow memory regions and that
> memory gets allocated for something that gets used regularly, then we might
> get a general slowdown. Hard to identify, though :)
> 
> >
> >> [    3.758596] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> >> [    3.759372] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> >> [   16.177983] ACPI: 13 ACPI AML tables successfully acquired and loaded
> >> [   17.099316] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> >> [   18.969959] ACPI: EC: EC started
> >
> > And here:
> >
> >> [   36.566608] PCI: CLS 64 bytes, default 64
> >> [   36.575383] Trying to unpack rootfs image as initramfs...
> >> [   44.594348] Initramfs unpacking failed: Decoding failed
> >> [   44.765141] Freeing initrd memory: 46348K
> >
> > Also seeing soft lockups:
> >> [  124.588634] watchdog: BUG: soft lockup - CPU#1 stuck for 23s!
> >> [swapper/1:0]
> 
> Yes, I noticed that -- there is a heavy slowdown somewhere.
> 
> As that patch is v5.10 already (and we're close to v5.12) I assume something
> is particularly weird about the platform you are running on - because this is
> the first time I see a report like that.

Well, this platform is not yet widely available outside of AMD so it's not likely to have been seen by anyone else, but there is nothing special about it compared to any other AMD platforms beyond that that I am aware of.

Alex

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
