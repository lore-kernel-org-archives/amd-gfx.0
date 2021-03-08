Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DB0C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 15:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF1A6526B
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 15:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF1A6526B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDBE989BD5;
	Mon,  8 Mar 2021 15:28:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A26398922E
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 15:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQQmaYPDPJpNdkNlPrm5XTe39WDlM7jf4DBG+nY1eBBtJDFciTH8o6q9NIo/fNSP3AWBPTIhLR2Q1JcqGWHrECTJLvQ3KCMhADj0MVkUFkwNrLzvNIe3JzIZce7vO0uJtcnEpruzbR1J+etbkrQP0XeG+64dkJv+883VqMe1BN93rRiB0N4Trp0N8RhzJ/OWVr1pWSDqbqqPxxnjY7pSK48dUNk3uQYOp7daN30eFNMkYP2HcsckQFA7mSGfC6Xiuu+poh32hCGCTwuYOw4ca/bjYy8gxwWNvE5WnlVquu7EspLnba21jKcgcFy8ehn7WJVzymRqEpXSziFRUiEHZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qdbMwYQMXOPGsuKJtUjth812t3pD3SwnifBSuDo4xE=;
 b=eMrgacbxugh9NL6zUo4Zwz197FgZssOP7tRzltf712y4iJkmnhSIfXhgHIg5+gWwOoBFg3pQC3js7/y/vVl9xi5JOYzH92Puuk6+iDfui2fVEKE/numA0Gq2E4t5YjqsSu2zVXumGaHV95aFkrZ74r1RVz2738/DCQYYeDIhXmfw1MiqMmqhk21EpmqreFHhg2hUo988asIhQaxhKXW+tlCFrDtqOOFmGO/TkowId0O4tI3zOSRaJO0eYHhqDOruS2uqvcD/u4uwLBFa4raoJibHZd3zzqLF4jG2xBcyR2FU/VrKISPfemnsMZ6HOQQTflZjY8j9eJe/JbpReLqEjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qdbMwYQMXOPGsuKJtUjth812t3pD3SwnifBSuDo4xE=;
 b=H04XgZUOTo9vFQt95BkPaLXWwsNuZPAFQa/1gB2JglVHve3A7hUzW3WnqH03zMo4FOAvnTWmd2di+YK7/rDYb3pMM75s4wX5sJ+YdvcxH+UZFcIVLjRBeXKIou+3yq1Q5yM5AtQb1J76ISjdEkKqIGS7FOmouS9k2/jrSTePu/8=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB3738.namprd12.prod.outlook.com (2603:10b6:5:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 15:27:58 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 15:27:58 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
Thread-Topic: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive
 duirng probe
Thread-Index: AQHXEehnkJi0ZBdQLUmnTOEKi9nTFKp1xzgAgABa9PCAAFhyAIAA8H4ggAAJLuCAAjBVgIAAk2Mg
Date: Mon, 8 Mar 2021 15:27:58 +0000
Message-ID: <DM6PR12MB3835DDDB171EA71175FA16F2F4939@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210305175257.32219-1-shaoyun.liu@amd.com>
 <34643514-c054-242a-336e-1ac9ab7ffcc7@amd.com>
 <DM6PR12MB3835CA23C6EA827DE36FC1A1F4959@DM6PR12MB3835.namprd12.prod.outlook.com>
 <69c471aa-3a68-6a54-608f-c03c73c0b248@amd.com>
 <DM6PR12MB3835E7CD4FAC9CFCE33549FCF4959@DM6PR12MB3835.namprd12.prod.outlook.com>
 <DM6PR12MB3835340976F1AB36BA768D4FF4959@DM6PR12MB3835.namprd12.prod.outlook.com>
 <4726b422-1ec8-b9a4-dbf2-578280a76b01@amd.com>
In-Reply-To: <4726b422-1ec8-b9a4-dbf2-578280a76b01@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-08T15:27:50Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f76a45bf-5b39-4fc2-a264-bdf890a85d82;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3bc0:316:65ee:b0a0:8b9f:261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1bc3b429-5f87-43da-b377-08d8e246c0c1
x-ms-traffictypediagnostic: DM6PR12MB3738:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3738E085AF8A70E1703DF152F4939@DM6PR12MB3738.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CwvjsEaPomIvG7Cmy58CkaFhjdFd4No2daz7/tHZNQP8jukZkQZ1Dt1PNmRQNdJWruWMQc67fb/oyFDiDWdY4USZSROfkrE7zG/8jfvpJ3axqLXy+NawCsD0EHgradJs1Gc08f2ytoPuS9eyIMaxUAerH2bwhyc7NZdSauFIo4fQDmKf77QlvTtKtlS/8XZlCOph/bGRJzQi0EyB15xI/I3LWYdDaNZ/HrqByZwV4rmZp9tDtVHwO6kGbaldlTT90QwGpy5O9y+vbDiu6ARso4WrqAuj3utDLW9Sn01RmaWDMYsIjHnFrviNjEIVD3GksPPM9ZlmH7UeO/1ikzbiz5fVvt8j+uQE+fm/tOOjpbbPefKZpWyB5WUNmnUgoPJYSL5PF2ksakN3drOGJUWXajXh2KVOQICq+nauAFkzMpvvwQhyiNj+oESxeIBzvZcXtPb6K1aef61ulL0NAok/4tIhoyPzC04De7iEAF6KB+JArx0EMvGPu+dmM3ZlyNQrvkhqT6c4jG48FDU2OurU/XzLK0jNdOqyhuOkOoEH2fxYO1MUG4mdAiLbd4BGmmwWJAZREjvOOrdvnMWNu219vh7NmuHUqTzPVEhuMR+SVPE7SI0VSilTAAH8wAz8mlu22gmV2MByH3/ABaoYv6vnGw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(9686003)(55016002)(110136005)(30864003)(8676002)(7696005)(71200400001)(8936002)(66476007)(76116006)(83380400001)(316002)(66946007)(186003)(64756008)(5660300002)(66446008)(52536014)(86362001)(66556008)(966005)(6506007)(478600001)(53546011)(45080400002)(33656002)(2906002)(21314003)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?YzZlcHVYSElMaWNXaFpUbHE1SEV3VkU2a3lrN3RqVzdieUh5TUVGN1NpUFV5?=
 =?utf-8?B?bitEOVNlNklmT28zSXd6aEtaSTB5d21YZ0N3UGYrVWptai92L2NOZVpjOE0w?=
 =?utf-8?B?WktxbCs2blRUUUM4b1BycUJ2NUF4U2RHSFBOK2JzQW1PeHVTazN0dWl2aEp0?=
 =?utf-8?B?TWxqZ0JMN3ptT1pSclVlVHZndGd0QWpxVVdib1JCMUsrNE1HN0Q5aytLTEwv?=
 =?utf-8?B?WWFqcC9YcVFhcmpCOWVSWXdUQmU4ZVJXNGJsNzZ0M3E1UmtHK3hBNktsQ00r?=
 =?utf-8?B?RFhZZFhPZlQ4ZXZyVUFVY3hDYkM4UDhRWmpUYU9wRVJ2RjVjTE1IdGFpTlRL?=
 =?utf-8?B?NGM2cG9KSHNGeS85cytNQWhMMXhlQUZZdk1iOWNvMzFXWU9peXV2MlErN0hn?=
 =?utf-8?B?WStmNW5jbnRLNGRDR2RoQXNtdXdrNEEwTXpTRVJGd2JFNTJFZzNVOHlneWZN?=
 =?utf-8?B?MlI2MGQ5SXY2KzRlTDc0Zk9rTEo2SmZlMzlqT1FyZEx0ZlYwTElzSk5abSsx?=
 =?utf-8?B?c1pvU1BSakg4L3MzejhySE42cFhMVzZheGd1YXB5VTFDallJangydzFCdHdC?=
 =?utf-8?B?WHc1NkJGdUxuT1RSWUFnSFJrS3gvL2dleWcwR2tsYVJyM3cyb3Bxd2RsSTdZ?=
 =?utf-8?B?dTBwT0NJUzRrVDJBUUNkMkVPN1d3TXp5L0VoWWFWYlkyYWRrTzJHYnVlVTh0?=
 =?utf-8?B?SjdnVlpaYTJFYzNRR0c0NFR2dGZzMlN5ZWZvNFN2NEFjeFlCMmdMdjFJc3hS?=
 =?utf-8?B?WWVpOVVrdnR2cEpEL2hzSjhQV2dGNlFwTVpWeEFEVUtqNTFrQ0Y2WXpPMVRX?=
 =?utf-8?B?Z25aSnQ0aVJxeTdsR3cxTUQyd3VjZ1dHZFVnWURVM1JvQlZMOTkwQkNObU9F?=
 =?utf-8?B?c2YyMXRQZEMwY0pkQys3K29ORlJRVzdNd0plNDVZVHQxVlFWK0NZdGFlTDVq?=
 =?utf-8?B?ZTRkTVIyOGNWUzd4MGNEOE9WT3RlSzRxNzlMbGMwWk1uNGRia2NzQ0c4Yzhi?=
 =?utf-8?B?NFlmWnRMUFFrZVg2NEltTjQ2aGNaSm9Lalp1d0srQkV4c1VoQ3JDOGxINDlV?=
 =?utf-8?B?U1NTalNwZnVQTUtkakgwRjBJak8vTk5rcHJQb3A3NmJ2QUxaN01vd1NzbzBw?=
 =?utf-8?B?Z3V6TFNSbEJTOXIwdUdpTjU3bWRsN3NYbmtQK1lsVkJJRCtYUkhYU1I3c2pZ?=
 =?utf-8?B?d3BPWHRLWXpSbEtYYUtGRjNGSGtpMnZWMHRwUlI5YVR0MnBXZkZrZTQvYVlv?=
 =?utf-8?B?Q1kwZG5jZmtTMm1KYUg5ZCtYMlJrMDNha0p2RE1GVWdWY3p0SXJ5UnBlSzEv?=
 =?utf-8?B?eVBIRkwwb1hrTGJYK0pCaVppQU9QeEZsbjBxL0txT3JYUmZNMXlPdG1sLzF2?=
 =?utf-8?B?bTA1VHljTUpNRWZleFFHODJQcVF0ZkNuSWVCbGFLQmxLeGtnK0YyRHlzOUxS?=
 =?utf-8?B?by9OZlI3UGJYc1dML0FwdERvWStrM2thMWhEbEw5YXhYS2I1ZjA1V3pGa2l4?=
 =?utf-8?B?b3RuTUxXN3NmSUE1Y0FsTFBxaGk0VmZWRlFXeXNQMFZtUEhObk1HYit2YnZU?=
 =?utf-8?B?MUNNV2dNYzNBRE5aUmNPQjlROXFCcnU0OGQrSGMzeFdVZmZHOXdRWVJpUVRN?=
 =?utf-8?B?Ykk3TmF3dk14Zk94ek1ISnNOdkVFUTZjRmJpcDAxcDJ0M0ZwR1RQMVF1ZU9o?=
 =?utf-8?B?R0E0dTg1M2xjOFBEV2dRUjZGdFZXSkZTNFBkUkRvWU90dlBVWWFWcjc1Nno2?=
 =?utf-8?B?WEZuYWZjaTNaRk5tbXlIR0tsejl6d1hOUGFrenF3UDNEVlViTmZmbGVqcisw?=
 =?utf-8?B?RTNXcUQxaUVYTktBYkRRQ2VEbUVJWWJocnFBU0dWaDdVNks3bTNubGQ2SWE0?=
 =?utf-8?Q?Uc988ZnpYP4EC?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc3b429-5f87-43da-b377-08d8e246c0c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 15:27:58.1283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4d9TObVGETZl7+gUkAlMn1QsyYHD6mdydHjBluzL9lJsOQtrjxmS+WoYq4hB7RTRtg0UQzfj3RAKg+tC+kUaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3738
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Check the function amdgpu_xgmi_add_device, when  psp XGMI TA is bot available ,  the driver will assign a faked hive ID 0x10 for all  GPUs, it means all GPU will belongs to one same hive .  So I can still use hive->tb to sync the reset on all GPUs.   The reason I can  not use the default amdgpu_do_asic_reset function  is because we  want to build correct hive and node topology for all GPUs after reset, so we need to call amdgpu_xgmi_add_device inside the amdgpu_do_asic_reset function . To make this works ,  we need to destroy the hive by remove  the device (call amdgpu_xgmi_remove_device) first , so when calling amdgpu_do_asic_reset ,  the  faked hive(0x10) already   been destroyed. And  the hive->tb will not work in this case .   That's the reason I need to call the reset explicitly with the faked hive and then destroy the hive ,  build the device_list for amdgpu_do_asic_reset without the hive . 
Hope I explain it clearly . 

Thanks 
Shaoyun.liu

-----Original Message-----
From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com> 
Sent: Monday, March 8, 2021 1:28 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng probe

But the hive->tb object is used regardless, inside amdgpu_device_xgmi_reset_func currently, it means then even when you explcicitly schdule xgmi_reset_work as you do now they code will try to sync using a not well iniitlized tb object. Maybe you can define a global static tb object, fill it in the loop where you send xgmi_reset_work for all devices in system and use it from within amdgpu_device_xgmi_reset_func instead of the regular per hive tb object (obviosly under your special use case).

Andrey

On 2021-03-06 4:11 p.m., Liu, Shaoyun wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> It  seems I can  not directly reuse the reset HW  function inside the  amdgpu_do_asic_reset,  the  synchronization is based on hive->tb,   but as explained , we actually don't know the GPU belongs to which hive and will rebuild the correct hive info inside the amdgpu_do_asic_reset function with amdgpu_xgmi_add_device .  so I need to remove  all GPUs from the hive first . This will lead to the sync don't work since the hive->tb will be removed as well when all GPUs are removed .
> 
> Thanks
> shaopyunliu
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
> Liu, Shaoyun
> Sent: Saturday, March 6, 2021 3:41 PM
> To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; 
> amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI 
> hive duirng probe
> 
> [AMD Official Use Only - Internal Distribution Only]
> 
> I call the amdgpu_do_asic_reset with the parameter skip_hw_reset = true  so the reset won't be execute twice .  but probably I can  set this parameter to true and remove the code schedule for reset since now I already build the device_list not based on hive. Let me try that .
> For the  schedule delayed work thread with AMDGPU_RESUME_MS, It's actually not wait for SMU  to start. As I explained , I need to reset the all the GPUs in the system since I don't know which gpus belongs to which hive.  So this time is allow system to probe all the GPUs  in the system which means when this delayed thread starts ,  we can assume all the devices already been  populated in mgpu_info.
> 
> Regards
> Shaoyun.liu
> 
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Saturday, March 6, 2021 1:09 AM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI 
> hive duirng probe
> 
> Thanks for explaining this, one thing I still don't understand is why you schedule the reset work explicilty in the begining of amdgpu_drv_delayed_reset_work_handler and then also call amdgpu_do_asic_reset which will do the same thing too. It looks like the physical reset will execute twice for each device.
> Another thing is, more like improvement suggestion  - currently you schedule delayed_reset_work using AMDGPU_RESUME_MS - so i guesss this should give enough time for SMU to start ? Is there maybe a way to instead poll for SMU start completion and then execute this - some SMU status registers maybe ? Just to avoid relying on this arbitrary value.
> 
> Andrey
> 
> On 2021-03-05 8:37 p.m., Liu, Shaoyun wrote:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> Hi,  Andrey
>> The existing reset function (amdgpu_device_gpu_recover or amd do_asic _reset) assumed driver already have  the correct hive info . But in my case, it's  not true . The gpus are in a bad state and the XGMI TA  might not functional properly , so driver can  not  get the hive and node info when probe the device .  It means driver even don't know  the device belongs to which hive on a system with multiple hive configuration (ex, 8 gpus in  two hive). The only solution I can think of is let driver trigger the reset on all gpus at the same time after driver do the minimum initialization on the HW ( bring up the  SMU IP)  no matter they belongs to the same hive or not and call amdgpu_xgmi_add_device for each device after re-init .
>> The 100 ms delay added after the baco reset . I think they can be removed . let me verify it.
>>
>> Regards
>> Shaoyun.liu
>>
>>
>>
>> -----Original Message-----
>> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>> Sent: Friday, March 5, 2021 2:27 PM
>> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI 
>> hive duirng probe
>>
>>
>>
>> On 2021-03-05 12:52 p.m., shaoyunl wrote:
>>> In passthrough configuration, hypervisior will trigger the 
>>> SBR(Secondary bus reset) to the devices without sync to each other.
>>> This could cause device hang since for XGMI configuration, all the 
>>> devices within the hive need to be reset at a limit time slot. This 
>>> serial of patches try to solve this issue by co-operate with new SMU 
>>> which will only do minimum house keeping to response the SBR request 
>>> but don't do the real reset job and leave it to driver. Driver need 
>>> to do the whole sw init and minimum HW init to bring up the SMU and 
>>> trigger the reset(possibly BACO) on all the ASICs at the same time
>>>
>>> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
>>> Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
>>> ---
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  13 +++
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 102 +++++++++++++++------
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  71 ++++++++++++++
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |   1 +
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |   8 +-
>>>     5 files changed, 165 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index d46d3794699e..5602c6edee97 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -125,6 +125,10 @@ struct amdgpu_mgpu_info
>>>     	uint32_t			num_gpu;
>>>     	uint32_t			num_dgpu;
>>>     	uint32_t			num_apu;
>>> +
>>> +	/* delayed reset_func for XGMI configuration if necessary */
>>> +	struct delayed_work		delayed_reset_work;
>>> +	bool				pending_reset;
>>>     };
>>>     
>>>     #define AMDGPU_MAX_TIMEOUT_PARAM_LENGTH	256
>>> @@ -1124,6 +1128,15 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
>>>     bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
>>>     bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
>>>     
>>> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>> +				  struct amdgpu_job *job,
>>> +				  bool *need_full_reset_arg);
>>> +
>>> +int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>> +			  struct list_head *device_list_handle,
>>> +			  bool *need_full_reset_arg,
>>> +			  bool skip_hw_reset);
>>> +
>>>     int emu_soc_asic_init(struct amdgpu_device *adev);
>>>     
>>>     /*
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 3c35b0c1e710..5b520f70e660 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -1220,6 +1220,10 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>>>     		}
>>>     	}
>>>     
>>> +	/* Don't post if we need to reset whole hive on init */
>>> +	if (adev->gmc.xgmi.pending_reset)
>>> +		return false;
>>> +
>>>     	if (adev->has_hw_reset) {
>>>     		adev->has_hw_reset = false;
>>>     		return true;
>>> @@ -2149,6 +2153,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>>>     			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
>>>     				continue;
>>>     
>>> +			if (!adev->ip_blocks[i].status.sw)
>>> +				continue;
>>> +
>>>     			/* no need to do the fw loading again if already done*/
>>>     			if (adev->ip_blocks[i].status.hw == true)
>>>     				break;
>>> @@ -2289,7 +2296,10 @@ static int amdgpu_device_ip_init(struct 
>>> amdgpu_device *adev)
>>>     
>>>     	if (adev->gmc.xgmi.num_physical_nodes > 1)
>>>     		amdgpu_xgmi_add_device(adev);
>>> -	amdgpu_amdkfd_device_init(adev);
>>> +
>>> +	/* Don't init kfd if whole hive need to be reset during init */
>>> +	if (!adev->gmc.xgmi.pending_reset)
>>> +		amdgpu_amdkfd_device_init(adev);
>>>     
>>>     	amdgpu_fru_get_product_info(adev);
>>>     
>>> @@ -2734,6 +2744,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>>>     			adev->ip_blocks[i].status.hw = false;
>>>     			continue;
>>>     		}
>>> +
>>> +		/* skip unnecessary suspend if we do not initialize them yet */
>>> +		if (adev->gmc.xgmi.pending_reset &&
>>> +		    !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
>>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
>>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
>>> +			adev->ip_blocks[i].status.hw = false;
>>> +			continue;
>>> +		}
>>>     		/* XXX handle errors */
>>>     		r = adev->ip_blocks[i].version->funcs->suspend(adev);
>>>     		/* XXX handle errors */
>>> @@ -3407,10 +3427,28 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>     	 *  E.g., driver was not cleanly unloaded previously, etc.
>>>     	 */
>>>     	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
>>> -		r = amdgpu_asic_reset(adev);
>>> -		if (r) {
>>> -			dev_err(adev->dev, "asic reset on init failed\n");
>>> -			goto failed;
>>> +		if (adev->gmc.xgmi.num_physical_nodes) {
>>> +			dev_info(adev->dev, "Pending hive reset.\n");
>>> +			adev->gmc.xgmi.pending_reset = true;
>>> +			/* Only need to init necessary block for SMU to handle the reset */
>>> +			for (i = 0; i < adev->num_ip_blocks; i++) {
>>> +				if (!adev->ip_blocks[i].status.valid)
>>> +					continue;
>>> +				if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
>>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
>>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
>>> +					DRM_DEBUG("IP %s disabed for hw_init.\n",
>>> +						adev->ip_blocks[i].version->funcs->name);
>>> +					adev->ip_blocks[i].status.hw = true;
>>> +				}
>>> +			}
>>> +		} else {
>>> +			r = amdgpu_asic_reset(adev);
>>> +			if (r) {
>>> +				dev_err(adev->dev, "asic reset on init failed\n");
>>> +				goto failed;
>>> +			}
>>>     		}
>>>     	}
>>>     
>>> @@ -3541,19 +3579,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>     	/* enable clockgating, etc. after ib tests, etc. since some blocks require
>>>     	 * explicit gating rather than handling it automatically.
>>>     	 */
>>> -	r = amdgpu_device_ip_late_init(adev);
>>> -	if (r) {
>>> -		dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
>>> -		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
>>> -		goto failed;
>>> +	if (!adev->gmc.xgmi.pending_reset) {
>>> +		r = amdgpu_device_ip_late_init(adev);
>>> +		if (r) {
>>> +			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
>>> +			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
>>> +			goto failed;
>>> +		}
>>> +		/* must succeed. */
>>> +		amdgpu_ras_resume(adev);
>>> +		queue_delayed_work(system_wq, &adev->delayed_init_work,
>>> +				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>>>     	}
>>>     
>>> -	/* must succeed. */
>>> -	amdgpu_ras_resume(adev);
>>> -
>>> -	queue_delayed_work(system_wq, &adev->delayed_init_work,
>>> -			   msecs_to_jiffies(AMDGPU_RESUME_MS));
>>> -
>>>     	if (amdgpu_sriov_vf(adev))
>>>     		flush_delayed_work(&adev->delayed_init_work);
>>>     
>>> @@ -3570,6 +3608,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>     	if (amdgpu_device_cache_pci_state(adev->pdev))
>>>     		pci_restore_state(pdev);
>>>     
>>> +	if (adev->gmc.xgmi.pending_reset)
>>> +		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
>>> +				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>>> +
>>>     	return 0;
>>>     
>>>     failed:
>>> @@ -4240,14 +4282,16 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>>>     }
>>>     
>>>     
>>> -static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>> -					struct amdgpu_job *job,
>>> -					bool *need_full_reset_arg)
>>> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>> +				  struct amdgpu_job *job,
>>> +				  bool *need_full_reset_arg)
>>>     {
>>>     	int i, r = 0;
>>>     	bool need_full_reset  = *need_full_reset_arg;
>>>     
>>> -	amdgpu_debugfs_wait_dump(adev);
>>> +	/* no need to dump if device is not in good state during probe period */
>>> +	if (!adev->gmc.xgmi.pending_reset)
>>> +		amdgpu_debugfs_wait_dump(adev);
>>>     
>>>     	if (amdgpu_sriov_vf(adev)) {
>>>     		/* stop the data exchange thread */ @@ -4293,10 +4337,10 @@ 
>>> static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>     	return r;
>>>     }
>>>     
>>> -static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>> -			       struct list_head *device_list_handle,
>>> -			       bool *need_full_reset_arg,
>>> -			       bool skip_hw_reset)
>>> +int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>> +			  struct list_head *device_list_handle,
>>> +			  bool *need_full_reset_arg,
>>> +			  bool skip_hw_reset)
>>>     {
>>>     	struct amdgpu_device *tmp_adev = NULL;
>>>     	bool need_full_reset = *need_full_reset_arg, vram_lost = false; 
>>> @@
>>> -4310,6 +4354,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>>     		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>>>     			/* For XGMI run all resets in parallel to speed up the process */
>>>     			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
>>> +				tmp_adev->gmc.xgmi.pending_reset = false;
>>>     				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>>>     					r = -EALREADY;
>>>     			} else
>>> @@ -4348,10 +4393,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>>     	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>>>     		if (need_full_reset) {
>>>     			/* post card */
>>> -			if (amdgpu_device_asic_init(tmp_adev))
>>> +			r = amdgpu_device_asic_init(tmp_adev);
>>> +			if (r) {
>>>     				dev_warn(tmp_adev->dev, "asic atom init failed!");
>>> -
>>> -			if (!r) {
>>> +			} else {
>>>     				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
>>>     				r = amdgpu_device_ip_resume_phase1(tmp_adev);
>>>     				if (r)
>>> @@ -4384,6 +4429,9 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>>     				 */
>>>     				amdgpu_register_gpu_instance(tmp_adev);
>>>     
>>> +				if (!hive && tmp_adev->gmc.xgmi.num_physical_nodes > 1)
>>> +					amdgpu_xgmi_add_device(tmp_adev);
>>> +
>>>     				r = amdgpu_device_ip_late_init(tmp_adev);
>>>     				if (r)
>>>     					goto out;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 253c59e0a100..aebe4bc561ee 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -44,6 +44,7 @@
>>>     #include "amdgpu_amdkfd.h"
>>>     
>>>     #include "amdgpu_ras.h"
>>> +#include "amdgpu_xgmi.h"
>>>     
>>>     /*
>>>      * KMS wrapper.
>>> @@ -167,8 +168,13 @@ uint amdgpu_freesync_vid_mode;
>>>     int amdgpu_reset_method = -1; /* auto */
>>>     int amdgpu_num_kcq = -1;
>>>     
>>> +static void amdgpu_drv_delayed_reset_work_handler(struct 
>>> +work_struct *work);
>>> +
>>>     struct amdgpu_mgpu_info mgpu_info = {
>>>     	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
>>> +	.delayed_reset_work = __DELAYED_WORK_INITIALIZER(
>>> +			mgpu_info.delayed_reset_work,
>>> +			amdgpu_drv_delayed_reset_work_handler, 0),
>>>     };
>>>     int amdgpu_ras_enable = -1;
>>>     uint amdgpu_ras_mask = 0xffffffff; @@ -1297,6 +1303,71 @@ 
>>> amdgpu_pci_shutdown(struct pci_dev *pdev)
>>>     	adev->mp1_state = PP_MP1_STATE_NONE;
>>>     }
>>>     
>>> +/**
>>> + * amdgpu_drv_delayed_reset_work_handler - work handler for reset
>>> + *
>>> + * @work: work_struct.
>>> + */
>>> +static void amdgpu_drv_delayed_reset_work_handler(struct 
>>> +work_struct
>>> +*work) {
>>> +	struct list_head device_list;
>>> +	struct amdgpu_device *adev;
>>> +	int i, r;
>>> +	bool need_full_reset = true;
>>> +
>>> +	mutex_lock(&mgpu_info.mutex);
>>> +	if (mgpu_info.pending_reset == true) {
>>> +		mutex_unlock(&mgpu_info.mutex);
>>> +		return;
>>> +	}
>>> +	mgpu_info.pending_reset = true;
>>> +	mutex_unlock(&mgpu_info.mutex);
>>> +
>>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>>> +		adev = mgpu_info.gpu_ins[i].adev;
>>> +		r = amdgpu_device_pre_asic_reset(adev, NULL, &need_full_reset);
>>
>> Why amdgpu_device_pre_asic_reset is needed ?
>>
>>> +		if (r) {
>>> +			dev_err(adev->dev, "GPU pre asic reset failed with err, %d for drm dev, %s ",
>>> +				r, adev_to_drm(adev)->unique);
>>> +		}
>>> +		if (!queue_work(system_unbound_wq, &adev->xgmi_reset_work))
>>> +			r = -EALREADY;
>>
>> amdgpu_do_asic_reset bellow will already schedule xgmi_reset_work for this device, what you could do instead is call amdgpu_do_asic_reset for each member of the hive and because there is a task barrier in amdgpu_device_xgmi_reset_func, it will synchronize all the resets to same point in time already.
>>
>>> +	}
>>> +	msleep(100);
>>
>> What's the 100ms is wiating for ?
>>
>>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>>> +		adev = mgpu_info.gpu_ins[i].adev;
>>> +		adev->gmc.xgmi.pending_reset = false;
>>> +		flush_work(&adev->xgmi_reset_work);
>>> +	}
>>> +
>>> +	msleep(100);
>>
>> Same as above
>>
>>> +	/* reset function will rebuild the xgmi hive info , clear it now */
>>> +	for (i = 0; i < mgpu_info.num_dgpu; i++)
>>> +		amdgpu_xgmi_remove_device(mgpu_info.gpu_ins[i].adev);
>>> +
>>> +	INIT_LIST_HEAD(&device_list);
>>> +
>>> +	for (i = 0; i < mgpu_info.num_dgpu; i++)
>>> +		list_add_tail(&mgpu_info.gpu_ins[i].adev->reset_list,
>>> +&device_list);
>>> +
>>> +	/* unregister the GPU first, reset function will add them back */
>>> +	list_for_each_entry(adev, &device_list, reset_list)
>>> +		amdgpu_unregister_gpu_instance(adev);
>>> +
>>> +	r = amdgpu_do_asic_reset(NULL, &device_list, &need_full_reset, true);
>>> +	if (r) {
>>> +		DRM_ERROR("reinit gpus failure");
>>> +		return;
>>> +	}
>>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>>> +		adev = mgpu_info.gpu_ins[i].adev;
>>> +		if (!adev->kfd.init_complete)
>>> +			amdgpu_amdkfd_device_init(adev);
>>> +		amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>> +	}
>>> +	return;
>>> +}
>>> +
>>>     static int amdgpu_pmops_suspend(struct device *dev)
>>>     {
>>>     	struct drm_device *drm_dev = dev_get_drvdata(dev); diff --git 
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> index aa0c83776ce0..8c71d84a2fbe 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> @@ -149,6 +149,7 @@ struct amdgpu_xgmi {
>>>     	struct list_head head;
>>>     	bool supported;
>>>     	struct ras_common_if *ras_if;
>>> +	bool pending_reset;
>>>     };
>>>     
>>>     struct amdgpu_gmc {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>> index 659b385b27b5..b459ef755ea9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>> @@ -492,7 +492,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>>>     	if (!adev->gmc.xgmi.supported)
>>>     		return 0;
>>>     
>>> -	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>> +	if (!adev->gmc.xgmi.pending_reset &&
>>> +	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>>     		ret = psp_xgmi_initialize(&adev->psp);
>>>     		if (ret) {
>>>     			dev_err(adev->dev,
>>> @@ -538,7 +539,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device
>>> *adev)
>>>     
>>>     	task_barrier_add_task(&hive->tb);
>>>     
>>> -	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>> +	if (!adev->gmc.xgmi.pending_reset &&
>>> +	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>>     		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
>>>     			/* update node list for other device in the hive */
>>>     			if (tmp_adev != adev) {
>>> @@ -567,7 +569,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>>>     		}
>>>     	}
>>>     
>>> -	if (!ret)
>>> +	if (!ret && !adev->gmc.xgmi.pending_reset)
>>>     		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
>>>     
>>>     exit_unlock:
>>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CSh
> aoyun.Liu%40amd.com%7C73608bda6abd48a3047608d8e0e02e4f%7C3dd8961fe4884
> e608e11a82d994e183d%7C0%7C0%7C637506600750277165%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C1000&amp;sdata=2qASlLYQ08twP0Ud5EcisCsVlJ9WG0QJv5idbuhDe4o%3D&amp;re
> served=0
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
