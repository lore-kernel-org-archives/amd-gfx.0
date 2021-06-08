Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0014EC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 02:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31A4610A1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 02:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31A4610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D426EA78;
	Tue,  8 Jun 2021 02:35:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F1F6EA78
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 02:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iqk17J2HBUodxA812efplbjaWVNdj/85qap9yfVofo29uUQ+WsqfdsB8j46z7yAS2aJIIyt/UNzWWC867JldtVIYnYDW42VwjEd0V2riaQD7MrXc7iAhP6jjz8d582lY07KomDjD8uqz7GBNiAF0M+zDvrgI3/muIRNTk5zjUksdMq3uibBc1hyUGNaVh13z28aml42GK0uwQck8/Raf0FWN+orDIaSaMXu3mzcBcMYko0G1/WekzidgO3Q7skiDU+tEGdMewky1lYbbljxMzTypXe5wDgvNNPaeUtHcvKttd0IaiUR2jrww0d/3SWlViCO8S6Xmb2sR1pAr5GD50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHliAdf8pcubGqlyvkYS/4+Q/c5gTJiuYzWrDWNDK+U=;
 b=T3DHqZzON6P87cUykKHQUa8zJV0Tv0IETXWj0ZEUL0yrlLlsSX5RkhruKEcUhwXGlVUbqqKHHbXsVet6Yz+ab0z7pjoYKsh41R5NFCdWo2Zgl2cS3KmifJdjUumS9r3+xb8xPyOButhDT4yWjWeudhy7MeCqBgOUUs3OXugfpPnv/1LM3PP5KY/+2N5akGDiKw54vUfnIZzfG5zrbsHDL/RGoGuwexNN83TeYnNd+Wvn1iQU1/xVVUV9M18mcbj/f4O3JCN+cTigdgDIfGewC8p2weOdVRCvFlIPb2mdUUTiEH/egK2rjRQI5da6jpv0CoG2iq7+7Fw1MLH0ODhjFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHliAdf8pcubGqlyvkYS/4+Q/c5gTJiuYzWrDWNDK+U=;
 b=2rwam4EXfaSJYsE0Ui/5CROQkmKpwHtHyi5kwEeDeUJcP0FcVDaEoDawyo87uI21KIwvc9R1Z7LP2pIHWfy5/1se5eBZ2x5su8KHdIvUzDmRoyZgG6XPcHzTlvRuoVarV2A+j26s7J8E68AEHXCmuNn+GXyOIixrqU09JuY+wq0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3369.namprd12.prod.outlook.com (2603:10b6:5:117::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.27; Tue, 8 Jun 2021 02:35:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 02:35:11 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 4/5] drm/amd/pm: clear the cached dpm feature status
Thread-Topic: [PATCH V2 4/5] drm/amd/pm: clear the cached dpm feature status
Thread-Index: AQHXWShNz4RQ8JhOG0ijdNT8ThOKqqsDvucAgARnz5CAAA52gIABMxsQ
Date: Tue, 8 Jun 2021 02:35:11 +0000
Message-ID: <DM6PR12MB2619D96904E624C42D6CDD27E4379@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210604095823.1403271-1-evan.quan@amd.com>
 <20210604095823.1403271-4-evan.quan@amd.com>
 <83d7ff01-061e-707a-0774-fc29e05c2684@amd.com>
 <DM6PR12MB2619D1A458C9D391A5A57EE8E4389@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CH0PR12MB534847E329700B54168C4A1797389@CH0PR12MB5348.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB534847E329700B54168C4A1797389@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-08T02:35:05Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e3db6208-c94d-4b2c-805d-4f6d4b07e045;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43fe0d42-34ff-4f8c-f3e8-08d92a260a2f
x-ms-traffictypediagnostic: DM6PR12MB3369:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB33696E918CF165789EB22364E4379@DM6PR12MB3369.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cgl8FLqILeb9OZNsBRTVX6tKhiRyDEm7Z6TTDUmZ+6+rCu+Ej2+JobHdN5Xjj4KZAfA6KqUjAv0Tx0l8kRMGHpoKWQzbjvuyCN+YkJo468Jbdzx0H7Cl8mzLu31sNcq/AxVT4WBxlVeN1BHdRyBBjm3IJcdKhaUg0TAE40mQojz5patcrxjWqqpPU9Dnj1OAgDTXKUzRPBZB729U7wtZ5LiacUCRQ1SsjDQceEe7djF8z2QspdS+4EvT4p6l0F/VzF8LLi4sW9uEo3VKdCPVGl4kYt9Salvo6+d4G3SSPZEEyaS4HrxlmHweX2MUyTRB9zYnhqjnR+Cvqoj9q3NIBLXLNlYLRatSoosLR+wQCRz2J931aktfrxtk4sVj6U7wL67pJ3lvv6CzKHTPBfY3v7GpsirW/bTOmaATQhaznATxN5bgaj/R7M3hLRvnn/6LB8nGPsjKexrLIGGp3b125zuVkmmtWgo9YwZq9vOKcfD0m0pv5Yg2GE3y9k9oUOzQ0/KddXHXAklAPnyw6EeKWRe4oFPjdeZ9MFOBHpyvYwdo0Q7CoT7+USVFbBW5WcMqddDtZNOE3gAIcAErOAozYXyM0tU3PKOvoUl0bbXl+p0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(9686003)(53546011)(5660300002)(76116006)(30864003)(52536014)(478600001)(2906002)(6506007)(33656002)(55016002)(83380400001)(66446008)(66946007)(64756008)(66556008)(66476007)(186003)(71200400001)(26005)(8676002)(316002)(8936002)(110136005)(122000001)(7696005)(38100700002)(86362001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STdWNEp6NWRmU052Zng0RUFMOG9VVUhrdktFZzRjbUZzSXZ2UVpDb01VVjRs?=
 =?utf-8?B?RkVPbThYa1B0UGdYelR5TVd5QkhvUk93elFKa0xHMEVPOVR6RjZaMmRFczRX?=
 =?utf-8?B?WkFrOG1uUXk0bnFnd21hR0d1R1dRdVM5NDY4Y3VTdk5NejlFK2ZIUHZlejlE?=
 =?utf-8?B?R0t6ekp0NjZzRElDcVc2TjVxOHFSS0dFTTZYQjc3UHlsMEU5RGRpaUovZUl0?=
 =?utf-8?B?bU02Y0llaEs3VVhsREo3WnNZTmdPeFpPa0RPT1V1QWMxc2pROCszMlZ0RGQ2?=
 =?utf-8?B?Sk1rSDRPcDRSamNEVXpMYzBnc3dIM1FNKzgwQ1ltSjdDd1c3bE1SMlpFMGFB?=
 =?utf-8?B?dkZIcXpBd3JFUmJORWZ4bzBmVE5Rc0wvTE9idXVMWFgzTm9uVUg5WmMyWmcx?=
 =?utf-8?B?b201bkw4ZWZYWExxSmJ6N2NDYXNxQld2dXB6dE1HZGRWVnhFclE1N0RaUkYw?=
 =?utf-8?B?UDZsVUcrWGZXNG4yWGE2ekV0V2ovd3lVcG9WRG1kclBDS3lkRzluMGZnS0p0?=
 =?utf-8?B?YWhCeUZxOTlobEdWS25GZmJxcFZCWWgwYktDNG90blMrSjhQK3dSYzI2UEg3?=
 =?utf-8?B?SUttc1dLbVRSa011Y1dQNFZ0ZWdWYWozZ1NGd1N5MklobVBHVW85Yy85QUww?=
 =?utf-8?B?YUlRN1doUTZROG5xL25mUWVzZjMydGVQbXBGVGlLRlYrbjRTNGo0QkdxcHJv?=
 =?utf-8?B?S2ZmYUkyYzAySUF4a3ExWWJFN295UzNmQzdEUGJVZTN6WVVXVE9oSXRSOXlr?=
 =?utf-8?B?a3Z2cXRDVFZ2cDM5NFNwYjNXUjMzRHdWK0NRSktuNUMzL3l3SXVUVldlZDJW?=
 =?utf-8?B?WXpRM2tGTmY5WU9FY2F1eWtQM0MzeGtMYUFNc3dzVkZ4NkJzS3FubnZYU24w?=
 =?utf-8?B?MndTUHpDcWpWNmt6c2d5RDZLK1I4MTJObm9hT0E5RXY1YVpzdDBVWVJLWmNF?=
 =?utf-8?B?V3pHTm5KQ1ZDSWUrSDM3cWlGRUlhcEh0akg4ZWlRSDY3NENHZWhadEVJSFlC?=
 =?utf-8?B?K3k4U1A3MVBPZmtVUkdpcGxpRGMvbFRjb1pwd3REemVacC82ODRXUU16T3F1?=
 =?utf-8?B?MjlicU5ra0s3RUxkTWZUMi9JWGVna0M5MEtnNXNWS204WERqZi9URWVFcm03?=
 =?utf-8?B?YmZRMk9JZVVNY050L3lZOFVWUmRmQmwzYjlVTjJlRXhxZU8xS21TMGFBQVNT?=
 =?utf-8?B?dnRpU2ZiYm5rRHV4WnNxYzZqY0Y4KzR2cGpFYzZERnVzSU1DQm5WaWpvU1Az?=
 =?utf-8?B?SmRSZno3V1RlSDZEb2Q5NDJPTVJnaDhjK0RGMVVsYXdUYjdta2h1R1VmM25E?=
 =?utf-8?B?RExzMHdkSG5wU25Nak0wSHhPc2xSM01PMnB6OFZaR0tjQTl2aTI2aExUZE9N?=
 =?utf-8?B?TFZRbWd5WEFQYWNIaU91aVkxZFFrc2dWc1BUcW5UR1JaVmd4Y25WR3FsZU5v?=
 =?utf-8?B?Vy82VmtUdlVOZTJ0TzlXa0todXB4bmNOWlhuRmI3MEtkT3FhdS8wblM3MkFR?=
 =?utf-8?B?eG1TWVZzSDVHeUdwSGtzQU1HbUVOQ2VpMCtUS2VlVW1Rd0tkMUhUczlWbTAz?=
 =?utf-8?B?VEMydWhLQTB2K1piVDJ1NnhQUjZ5VUVnSEZmb2J2TGtmYksyUmRtL285UEJD?=
 =?utf-8?B?bDc0RTJFS3pzeGpZNWJTS0R5RVpxcWg0ditaUFYvaHpSSUU5SUthWDk2VSs4?=
 =?utf-8?B?bko4VFdGRDJEeXBsMDloeGo2Znd4LzVLektTTXhnNm1ZamZaOWF6dHVJM090?=
 =?utf-8?Q?8MhHXYiI4/I3zIuZneaiGKDvlA8RJpNCPxh4c7+?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fe0d42-34ff-4f8c-f3e8-08d92a260a2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 02:35:11.6854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0IwZ9hrRN539AISvtgt9r8VzuqciLv8KX3GkEjkGht4+OiEh8qEVC0/I5oh3TdsE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3369
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi Lijo,

Per original design, all non ASIC specific code goes to amdgpu_smu.c. To me, it sounds you want to separate some of them(from amdgpu_smu.c) into a new file. I'm OK with that.
However as I said, to do that, we may need to make the bitmasks stored in feature->enabled non asic bundled/specific. I need more time to consider and will put that on my TODO list.
For this specific patch, I will update it with code fit into smu_cmn_disable_all_features_with_exception(). Are you OK with that?

BR
Evan
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, June 7, 2021 4:05 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH V2 4/5] drm/amd/pm: clear the cached dpm feature
> status
> 
> [Public]
> 
> What about separating to smu_cmn_utils.c/smu_utils.c or similar which is
> meant for software based common/util functions?  In general, it will have sw
> based common funcs (not ASIC specific) and may be used outside (for ex: in
> amdgpu_smu.c). smu_cmn continues to have the hw based
> common/ppt_func routines.
> 
> smu_cmn_to_asic_specific_index is also a good candidate for such a function
> as it fetches the sw lookup map (may be moved later).
> 
> Thanks,
> Lijo
> 
> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Monday, June 7, 2021 1:04 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH V2 4/5] drm/amd/pm: clear the cached dpm feature
> status
> 
> [AMD Official Use Only]
> 
> Hi Lijo,
> 
> I got your concern. However, the problem is what amdgpu_smu.c can see is
> SMU_FEATURE_xxxxx_BIT(e.g. SMU_FEATURE_BACO_BIT) related.
> While the bit mask stored in feature->enabled is FEATURE_xxxxx_BIT(e.g.
> FEATURE_BACO_BIT which is asic specific) related.
> So, a SMU_FEATURE_BACO_BIT to FEATURE_BACO_BIT transfer is needed
> and for now this asic specific operation is performed in
> smu_cmn.c(smu_cmn_to_asic_specific_index).
> 
> The possible way to get this optimized I can see is either 1. try to fit this into
> smu_cmn_disable_all_features_with_exception()
> 2. make the bitmasks stored in feature->enabled are non asic specific ones.
> This will involve extra efforts and risks.
> I personally prefer the approach 1 above.
> 
> Any thoughts?
> 
> BR
> Evan
> > -----Original Message-----
> > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > Sent: Friday, June 4, 2021 7:56 PM
> > To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH V2 4/5] drm/amd/pm: clear the cached dpm feature
> > status
> >
> >
> >
> > On 6/4/2021 3:28 PM, Evan Quan wrote:
> > > For some ASICs, the real dpm feature disablement job is handled by
> > > PMFW during baco reset and custom pptable loading. Cached dpm
> > > feature status need to be cleared to pair that.
> > >
> > > Change-Id: I9e37d80e13599833301c04711b097fb37c2e41f9
> > > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > > ---
> > > V1->V2:
> > >    - correct the setting for baco bit(pointed out by Lijo)
> > > ---
> > >   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  6 +++++
> > >   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 19
> ++++++++++++-
> > -
> > >   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
> > >   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  1 +
> > >   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 25
> > +++++++++++++++++++
> > >   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 +++
> > >   drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 +
> > >   7 files changed, 54 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > > b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > > index fb7438224872..3f9b2a839a37 100644
> > > --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > > +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > > @@ -937,6 +937,12 @@ struct pptable_funcs {
> > >   	 */
> > >   	int (*disable_all_features_with_exception)(struct smu_context
> > *smu,
> > > enum smu_feature_mask mask);
> > >
> > > +	/**
> > > +	 * @clear_cached_dpm_feature_status_with_exception: Clear
> > cached dpm feature status with
> > > +	 *                                                  exception to those in &mask.
> > > +	 */
> > > +	int (*clear_cached_dpm_feature_status_with_exception)(struct
> > > +smu_context *smu, enum smu_feature_mask mask);
> > > +
> >
> > Since this is a just a utility function which clears sw bitmask
> > without touching hardware, do we need a ppt_func? In case that is
> > needed, we already have this -
> > smu_cmn_disable_all_features_with_exception. So, can't this remain as a
> standalone smu_cmn function which can be called from anywhere?
> > Nowadays, I get a red alert when a ppt_func gets added :)
> >
> > Thanks,
> > Lijo
> >
> > >   	/**
> > >   	 * @notify_display_change: Enable fast memory clock switching.
> > >   	 *
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > index c9a31556e077..aba475d06507 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > @@ -1352,6 +1352,16 @@ static int smu_hw_init(void *handle)
> > >   	return 0;
> > >   }
> > >
> > > +static void smu_reset_cached_dpm_feature_status(struct smu_context
> > > +*smu) {
> > > +	struct smu_feature *feature = &smu->smu_feature;
> > > +
> > > +	mutex_lock(&feature->mutex);
> > > +	bitmap_zero(feature->enabled, feature->feature_num);
> > > +	bitmap_zero(feature->supported, feature->feature_num);
> > > +	mutex_unlock(&feature->mutex);
> > > +}
> > > +
> > >   static int smu_disable_dpms(struct smu_context *smu)
> > >   {
> > >   	struct amdgpu_device *adev = smu->adev; @@ -1374,16 +1384,21
> > @@
> > > static int smu_disable_dpms(struct smu_context *smu)
> > >   	 */
> > >   	if (smu->uploading_custom_pp_table &&
> > >   	    (adev->asic_type >= CHIP_NAVI10) &&
> > > -	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
> > > +	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH)) {
> > > +		smu_reset_cached_dpm_feature_status(smu);
> > >   		return 0;
> > > +	}
> > >
> > >   	/*
> > >   	 * For Sienna_Cichlid, PMFW will handle the features disablement
> > properly
> > >   	 * on BACO in. Driver involvement is unnecessary.
> > >   	 */
> > >   	if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
> > > -	     use_baco)
> > > +	     use_baco) {
> > > +
> > 	smu_clear_cached_dpm_feature_status_with_exception(smu,
> > > +
> > SMU_FEATURE_BACO_BIT);
> > >   		return 0;
> > > +	}
> > >
> > >   	/*
> > >   	 * For gpu reset, runpm and hibernation through BACO, diff --git
> > > a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > > b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > > index afd4bd850c63..8c3ea20fb0f6 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > > @@ -3083,6 +3083,7 @@ static const struct pptable_funcs
> > navi10_ppt_funcs = {
> > >   	.get_enabled_mask = smu_cmn_get_enabled_mask,
> > >   	.feature_is_enabled = smu_cmn_feature_is_enabled,
> > >   	.disable_all_features_with_exception =
> > > smu_cmn_disable_all_features_with_exception,
> > > +	.clear_cached_dpm_feature_status_with_exception =
> > > +smu_cmn_clear_cached_dpm_feature_status_with_exception,
> > >   	.notify_display_change = smu_v11_0_notify_display_change,
> > >   	.set_power_limit = smu_v11_0_set_power_limit,
> > >   	.init_max_sustainable_clocks =
> > > smu_v11_0_init_max_sustainable_clocks,
> > > diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > index b4a2bb0f3f4c..14a14c30ee5e 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > @@ -3886,6 +3886,7 @@ static const struct pptable_funcs
> > sienna_cichlid_ppt_funcs = {
> > >   	.get_enabled_mask = smu_cmn_get_enabled_mask,
> > >   	.feature_is_enabled = smu_cmn_feature_is_enabled,
> > >   	.disable_all_features_with_exception =
> > > smu_cmn_disable_all_features_with_exception,
> > > +	.clear_cached_dpm_feature_status_with_exception =
> > > +smu_cmn_clear_cached_dpm_feature_status_with_exception,
> > >   	.notify_display_change = NULL,
> > >   	.set_power_limit = smu_v11_0_set_power_limit,
> > >   	.init_max_sustainable_clocks =
> > > smu_v11_0_init_max_sustainable_clocks,
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > index 0ceb7329838c..b9c38abc9d37 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > @@ -594,6 +594,31 @@ int
> > smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
> > >   						   0);
> > >   }
> > >
> > > +int
> smu_cmn_clear_cached_dpm_feature_status_with_exception(struct
> > smu_context *smu,
> > > +							   enum
> > smu_feature_mask mask) {
> > > +	struct smu_feature *feature = &smu->smu_feature;
> > > +	uint64_t features_to_disable = U64_MAX;
> > > +	int skipped_feature_id;
> > > +
> > > +	skipped_feature_id = smu_cmn_to_asic_specific_index(smu,
> > > +
> > CMN2ASIC_MAPPING_FEATURE,
> > > +							    mask);
> > > +	if (skipped_feature_id < 0)
> > > +		return -EINVAL;
> > > +
> > > +	features_to_disable &= ~(1ULL << skipped_feature_id);
> > > +
> > > +	mutex_lock(&feature->mutex);
> > > +	bitmap_andnot(feature->enabled, feature->enabled,
> > > +			(unsigned long *)(&features_to_disable),
> > SMU_FEATURE_MAX);
> > > +	bitmap_andnot(feature->supported, feature->supported,
> > > +			(unsigned long *)(&features_to_disable),
> > SMU_FEATURE_MAX);
> > > +	mutex_unlock(&feature->mutex);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   int smu_cmn_get_smc_version(struct smu_context *smu,
> > >   			    uint32_t *if_version,
> > >   			    uint32_t *smu_version)
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > > b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > > index da6ff6f024f9..12ad07132d15 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > > @@ -77,6 +77,9 @@ int smu_cmn_set_pp_feature_mask(struct
> > smu_context *smu,
> > >   int smu_cmn_disable_all_features_with_exception(struct smu_context
> > *smu,
> > >   						enum smu_feature_mask
> > mask);
> > >
> > > +int
> smu_cmn_clear_cached_dpm_feature_status_with_exception(struct
> > smu_context *smu,
> > > +							   enum
> > smu_feature_mask mask);
> > > +
> > >   int smu_cmn_get_smc_version(struct smu_context *smu,
> > >   			    uint32_t *if_version,
> > >   			    uint32_t *smu_version);
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> > > b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> > > index 33101dc93bcc..b12dcfab55fe 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> > > @@ -58,6 +58,7 @@
> > >   #define smu_feature_get_enabled_mask(smu, mask, num)
> > 		smu_ppt_funcs(get_enabled_mask, 0, smu, mask, num)
> > >   #define smu_feature_is_enabled(smu, mask)
> > 	smu_ppt_funcs(feature_is_enabled, 0, smu, mask)
> > >   #define smu_disable_all_features_with_exception(smu, mask)
> > 	smu_ppt_funcs(disable_all_features_with_exception, 0, smu, mask)
> > > +#define smu_clear_cached_dpm_feature_status_with_exception(smu,
> > mask)
> 	smu_ppt_funcs(clear_cached_dpm_feature_status_with_exception,
> > 0, smu, mask)
> > >   #define smu_is_dpm_running(smu)
> > 	smu_ppt_funcs(is_dpm_running, 0 , smu)
> > >   #define smu_notify_display_change(smu)
> > 	smu_ppt_funcs(notify_display_change, 0, smu)
> > >   #define smu_populate_umd_state_clk(smu)
> > 		smu_ppt_funcs(populate_umd_state_clk, 0, smu)
> > >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
