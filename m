Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FCFC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 15:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABF8208E4
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 15:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Y+IKzf6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABF8208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 429826E8EE;
	Tue, 16 Jun 2020 15:24:46 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 027426E840;
 Tue, 16 Jun 2020 07:49:18 +0000 (UTC)
IronPort-SDR: m+LVmmgTfCxrpJh5D49ASy6y7aVOEnajPrKozok0eK8+Xlt3Cj8N3jP6WZj/pXQWfKd795WFTf
 BzvQD2AGxgbg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2020 00:49:18 -0700
IronPort-SDR: Hy0iYbZPWQwddNTqq20vhUxlrD+hdeWG7Q4GQxBcBj5DGnIpk09+yxGRjms6i5ReR08HnbDEAH
 HQCB7Y1loPRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; d="scan'208";a="290974388"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
 by orsmga002.jf.intel.com with ESMTP; 16 Jun 2020 00:49:18 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 00:49:17 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX154.amr.corp.intel.com (10.22.226.12) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 00:49:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 00:49:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFbsJ1SIFspeW7LuXh5f4zVH/5b8fgpx3kYiRYhFuiOZ3JXB6O65dhm1eU38SCpAAvbUKeVNNlTC9sP066j+AcsOeo6MdYJ8f43nmRUX3qq1OSoeDaWLiAZfRdcADHUelk/T6IGblT6Tvf757l3K0BI4DsJy5bkIYxkC2xkMIok/4MWFM67/Hnp2L16t1kGcnMg6L0nCL4w0pnWRiU9l8D/y/nakk4gw8PrKFkFhpu/CdI/SGeZkePVx+hz3KPh+Q9MTN+JrEjBP2RmeWFMQNqsgUrYAFkTOPPGFspWrIy7EigjFDj31Ta1qHfrN2REYp5mNaND9PJA1eRN5h3iVqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOLznKOcV2fxRjo0KW9XCE/dUwRCJvEnvw4eE9mjhaE=;
 b=i3u2y0+pX9bC4kynudK68vOIPYXUuv5jQbZLLf3pNj11oHalgnHQSWUOn6ph3HSHaK/YyCQUdZx8goF1dqDlJtyJTYOiXgNCreuZ5kvl1JvzmWVKDYD0IaVs7kMrH8/qCnEOSaNfc7FMfjAsAH45/SAVMpLjoO0iE/iAPSY0l2xqLxPRoV4jA9UUcTgK8G5RhKxNeWYT3uRa6eKLrCERr4Xig5xl/nbM0RQrx9Umv1/iGbXpjbSeOlvXknRfZUqxeK/x54njEv33NKcikPk+vX/TeNAKxkcNPKp/XliljSNWvwoDjDfdccGSlGhI8PG8b/un3p0Uxn2QKuFkK1jDng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOLznKOcV2fxRjo0KW9XCE/dUwRCJvEnvw4eE9mjhaE=;
 b=Y+IKzf6u+fGy0sjLuZNhNNYkpqnb5IWFh7vg9SryZdKDKfQru8UuBUsO6MUHIxVGPRfCKqhLSbuZ78F5LXn47qMTzSG013pkcFKBT+98S/Os7mVPmDiHvm/gTsFUDEbE8gQDn5t2lfoApCSO5WeEiZGr16lEjDp/U+CoBrxpnME=
Received: from CY4PR11MB1528.namprd11.prod.outlook.com (2603:10b6:910:d::12)
 by CY4PR1101MB2296.namprd11.prod.outlook.com (2603:10b6:910:1a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 16 Jun
 2020 07:49:16 +0000
Received: from CY4PR11MB1528.namprd11.prod.outlook.com
 ([fe80::80a:cad3:9a37:28dd]) by CY4PR11MB1528.namprd11.prod.outlook.com
 ([fe80::80a:cad3:9a37:28dd%11]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 07:49:16 +0000
From: "Stankiewicz, Piotr" <piotr.stankiewicz@intel.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH v3 07/15] drm/amdgpu: Use PCI_IRQ_MSI_TYPES where
 appropriate
Thread-Topic: [PATCH v3 07/15] drm/amdgpu: Use PCI_IRQ_MSI_TYPES where
 appropriate
Thread-Index: AQHWPj7vM/CCLQ6EAkW2V+oqU90gLqjQu0AAgAoqcaA=
Date: Tue, 16 Jun 2020 07:49:14 +0000
Deferred-Delivery: Tue, 16 Jun 2020 07:49:07 +0000
Message-ID: <CY4PR11MB1528D5F37BFDFFC668A96315F99D0@CY4PR11MB1528.namprd11.prod.outlook.com>
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
 <20200609091804.1220-1-piotr.stankiewicz@intel.com>
 <CADnq5_N95PjqU4nMgZBL_PoNKk8ourb_k9HLGvR_RN5FeZ3tkg@mail.gmail.com>
In-Reply-To: <CADnq5_N95PjqU4nMgZBL_PoNKk8ourb_k9HLGvR_RN5FeZ3tkg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTUzYThmYzYtZTBiMy00MTRkLThjZTEtNGM0YTg3OTZjOGZiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidXJwTlZiNUVYdTRhMGJMUU15bVwvenkyWkxtSXNYMFY4aExsOGNSTWFrdDlcL2ZcL0p3aGFwOTJUQk5Rb2ZXNzNlUiJ9
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.191.221.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c575f4dd-bd87-4e65-867f-08d811c9c4de
x-ms-traffictypediagnostic: CY4PR1101MB2296:
x-microsoft-antispam-prvs: <CY4PR1101MB2296E3E86B8478411EFD1F71F99D0@CY4PR1101MB2296.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v1DgYlv/KLrsBXsfgXX2JQDcZEscwqNVE911ayXkCB2T0wSPH5Au2BZMpSDe7E2lmSC0io3JVZrKo9KRoL3TlLcp1AzVojdknjTv/gHR5xQzyVIpE9VCZ2ecuUqz9lpvzKBqwI+0/t/A+yO/stfVSqYykZGq4d4yuMsCk1g9Zlxp5rGJnScWFBB1ryq12UyxmPzU+7nV1kSjMqeLjsIivW49tAzxlMvKrZQx0jb8EY3Zfy+97qUmWTQZgRnFeXdII/W02RQWj21sFRT/EJp6OW+lk5qc2tKh71pir/iaZXrtby4NypTpkswdLeqauNk0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR11MB1528.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(376002)(39860400002)(396003)(346002)(366004)(7416002)(76116006)(8676002)(6916009)(66556008)(33656002)(478600001)(64756008)(66946007)(54906003)(6506007)(52536014)(4326008)(66476007)(66446008)(8936002)(83380400001)(4744005)(2906002)(53546011)(9686003)(5660300002)(71200400001)(55016002)(86362001)(186003)(7696005)(316002)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: WgnSWU8S9s0OfAz6FMZs5OiwTBvKUdJYTUnLnNk8a8l2EuBVLzXC9BC22M0aGnzUoALL9cxGk7jKvH1NzK9mhIMuemj1w+PW7raJsgkqE2ElT8a4EStF6vi8J5/FPUMN8txn72Mrjb1EZyVdXkBPJ47YKu0FmdEUFihZ7rFx6y7zpR8RI+znTxG5xO61kNO48tMqAuatUzf7tiOGj0qxP6LmdGwb2+BLPtrsKD4evJ1xQaxcySRnlFtLqbUK5ZFakGilSZBzXv0n9Y3iK6fQi5a3LhVzJdbvnOMJ5rwgSHs8L45/SiQIyq+cVVyW3h8xsdWPbdTROX1AterH0pnwsAV+lRGkUyFzm6KMmTCLadXX5E7QWEnFgqXUXXqRmRE7SfJFQzY/oZxUtn2MRBxbbgtKRjai6k1HWsmQLx8LxkM+GkbziMBLBdK6sZQKLA9A/hMkH8oH3sAw8Kj3soe5l3U1PMT7uSzrhxbCa6yoeMzwvg9qDlr3B/l6HsnIb83g
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c575f4dd-bd87-4e65-867f-08d811c9c4de
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 07:49:16.1191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZxOaGtNocYb+UfDqHLtnyQGHef8H3VX+ap2y7npPO+0WUrxavF+v6GnXLhW0euTruCTCN0lJTf18Yk68AKLW/JFo0HX1rZSyNYLr3mKA75k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2296
X-OriginatorOrg: intel.com
X-Mailman-Approved-At: Tue, 16 Jun 2020 15:24:44 +0000
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
Cc: David Airlie <airlied@linux.ie>, Linux PCI <linux-pci@vger.kernel.org>,
 Aurabindo
 Pillai <mail@aurabindo.in>, LKML <linux-kernel@vger.kernel.org>, amd-gfx
 list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Hawking
 Zhang <Hawking.Zhang@amd.com>, Sam Ravnborg <sam@ravnborg.org>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
 shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, June 9, 2020 10:24 PM
> 
> On Tue, Jun 9, 2020 at 5:18 AM Piotr Stankiewicz
> <piotr.stankiewicz@intel.com> wrote:
> >
> > Seeing as there is shorthand available to use when asking for any type
> > of interrupt, or any type of message signalled interrupt, leverage it.
> >
> > Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 

Thanks. Adding PCI_IRQ_MSI_TYPES won't land upstream. But I'll send
a patch with the other simplifications, just now.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
