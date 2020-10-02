Return-Path: <SRS0=93xL=DJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11D8C4363D
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 14:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36ADC206A4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 14:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JbCCuss5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36ADC206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD376E9A7;
	Fri,  2 Oct 2020 14:30:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C66596E9A1
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2020 14:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZO8PocSLGIl4xmT/bcunKDVLmHLojVvp/vfmZFe3nZUIJ5JciB273BpYYKUsI3MmBP3GFO6/fTREYlwH+f5BvSl3YIzb0HLc5o3SDLK0nPPYCtucFaQQ6UIv8aLhp0XT2Re3vfypQkhWNM9MHhilE7dfW+evA9qukiI9lWi+yeZt/baqgzK8LPZAEktvPhmJ232v4XHh09n1t/Sx5rCg3e/IdF/thwpTULy8SsuRPthBBAptvxYcLK4fR1bNi7aUcGX9j3kLVNLGjW4UbWpo4nj4pDsX3OdOFx6i5FsvB8KG9cqjMTwamhGHgQJcI9vwi+7Fj7x64uclR8+BGJIMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJv8+9OhF+WadcOT6Vb9oNWpFz+YtC/ciDxQQowfEJw=;
 b=Twk/AbaEK0Km6CY6zZp16ZWUkr4Q5duraHaGiaQssz5SZZ7CWXO4Hjm+z3IoqW6XAocaAYO7JbfDXpDwgUiEIO/VyjYztObJomxx00+aDm9eJQt96WUuDC4+cJtuIGeLc5uPIEU6dN7rRANJXYdMf4wW5MPY24EpIkGLiSE5CN6llTvS89U8SpzkENiUB1gAmka9RGyfM2DmE0qdrQdl02Qt/Vd/8HxSFsxWPjftutr28cgNOVtVqfTl/aACJOyBAxtEBI5FhA8FP7akT/3sRZ3iNidbgomxepQa3h17rzzQ9HsucsL/zRRCTXVp9dL6RjonCWoOPmeRyAt8BREiMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJv8+9OhF+WadcOT6Vb9oNWpFz+YtC/ciDxQQowfEJw=;
 b=JbCCuss5S0PIHiihiMvJc+1ko3rgOfb4t9pp5AS7wWOMEH5exOrPWxVwMixR+i5gUGCSJ4tOb6EI8DlunRUDhGteMhs+KXUsTdzbtx5UuQB2zqOBDIVlEce6PRVHYE+9KyTej0oacWKQ1hEAWX/4mjoFMxsY9GY4LCoL28oAXjQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4866.namprd12.prod.outlook.com (2603:10b6:208:1cf::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Fri, 2 Oct
 2020 14:30:35 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3433.036; Fri, 2 Oct 2020
 14:30:35 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH] PCI/ACPI: Whitelist hotplug ports for D3 if power managed
 by ACPI
Thread-Topic: [PATCH] PCI/ACPI: Whitelist hotplug ports for D3 if power
 managed by ACPI
Thread-Index: AQHWmHqRW/ArdKHcKEup0PjEoxxiSamEXH+AgAAAcUCAAAGjgIAAATlQ
Date: Fri, 2 Oct 2020 14:30:35 +0000
Message-ID: <MN2PR12MB4488B8C5D496821194171FCBF7310@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <cea9071dc46025f0d89cdfcec0642b7bfa45968a.1601614985.git.lukas@wunner.de>
 <CAJZ5v0h5dHp6C8rx-B-hS=6hJOvTHuY1K4590qkNzCAkoivK4g@mail.gmail.com>
 <MN2PR12MB44888EB0D4D9B3B1D43698B6F7310@MN2PR12MB4488.namprd12.prod.outlook.com>
 <CAJZ5v0itTBOvjMJVrWJwgC2xdEVHKb-=fWC5SidT_X5Lxpmb_g@mail.gmail.com>
In-Reply-To: <CAJZ5v0itTBOvjMJVrWJwgC2xdEVHKb-=fWC5SidT_X5Lxpmb_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-02T14:29:12Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=78758b12-cdce-4a91-858d-00009c875827;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-02T14:30:31Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 4e54d653-6546-41a0-bb7a-00008a71f6a3
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad8c4a7f-4ea5-4d8c-b950-08d866dfb9bd
x-ms-traffictypediagnostic: BL0PR12MB4866:
x-microsoft-antispam-prvs: <BL0PR12MB4866EAB7FE4A75E3CF8863A8F7310@BL0PR12MB4866.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jkmyqA5j4SYNzAeEAcF0LBzNm5jOyLptP0ijz8s1l+slO7e6IBzfs6+r1AoFMymnUvMDUFs/FdBNozPO9x1Y3WZ7RvT8nRX1/IRer+lXPI6b3IWNNBcg8PlxKUZmBmBz5mFUTj8f+YC51bzQR6JY9V8bfRoU0CHBX6yVE1d6GHQnB+wkoDDyPIrqZQ3qdwHUJcPZDbzy6kHjO362kRnyBH9850WGbQrODss+rqIvnpE4WV0MfigewnWBn/snYC7z75jaUPs1rPXA5Ef/AsKu58FxTY4aU9u/UnpYoqAhdQ/sfEkv+t+zMV1MfTt0DkHNHOag8oq0Ja30V1ud2q/JxK1xTgnZpvFQArrJdkrTxFJANKu3JziQ8UNK6qwydNNml6saSYRGnLZlYt2bmXh39g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(6506007)(53546011)(45080400002)(26005)(83080400001)(478600001)(9686003)(83380400001)(966005)(52536014)(7696005)(186003)(7416002)(55016002)(5660300002)(66476007)(66556008)(64756008)(8676002)(66446008)(2906002)(54906003)(6916009)(33656002)(66946007)(76116006)(8936002)(316002)(71200400001)(86362001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wQ03sQPbgIhDfdwABHmjslYFyHMYPJ/l7B0AXZsEa1xxn6Y8OH5+75no6yG5e/l6zBXrh4GfmMNFmSdcnC9GXPhivHN4EiT9A8I+cUQOH2dd/C4muWzcS8YuKrwjqjzeb2eY+eN8eqHV1qKhpoSNZXr8oVefSsYT0hPXVa/ON5UFFyOv3YwXxxWIF0s9Dwsa5Q6mZl2bYiATGezt+rYMXwW+76V43+nUOA9NdEA4PAov5voAEo1+WLCiLDweRhytgYOtInMGXW6QBhrXxm1rK+OC74Evqmk6+4mp6IACrEwlNLbrupPHLIQKDqbkO/ixT3T+9dW5l4huYygGRoz+3i404h85GCc8QbJqGuiK3y974HHsV4skhh0nQYZWCupBJcl7hQb+U2tINd3EAZAG0cWZCxOQ7q+vUc2cd/8OkA0GBmnwDGjHJgdJ757l6xQs3yAlWzmXoIAF9nt8wSOkbZXoShBqGfDF3fGa8wRfkBcemLMOIt5BxJR5PStiqfno8mxXXqEHqRZQsCQDy88bK05G+URhzn5ylb4y9dqaF/oL2X7r6qhuoBWRAWqrQYD8HxteCQwgKqsp7vDYGPoUCzsK9bL8B0A0BvAPp+MLnOJkjbgyk4mUHxrcWJU7Uoh1+1Tjh9aiKNzl1DAeePJi7Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8c4a7f-4ea5-4d8c-b950-08d866dfb9bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2020 14:30:35.1838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+gCnQDimKl3/x/kPtRL6uNKYkSl4gWAk+zGlh/3xEwMTuZSgaa7Dd0QjdZAI9y8BVpfkJjTirzqGP3deb7xJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4866
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
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, matoro <matoro@airmail.cc>,
 Linux PCI <linux-pci@vger.kernel.org>, Michal Rostecki <mrostecki@suse.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Shai Coleman <git@shaicoleman.com>, Lukas Wunner <lukas@wunner.de>,
 Bjorn Helgaas <helgaas@kernel.org>, Arthur Borsboom <arthurborsboom@gmail.com>,
 Aaron Zakhrov <aaron.zakhrov@gmail.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]



> -----Original Message-----
> From: Rafael J. Wysocki <rafael@kernel.org>
> Sent: Friday, October 2, 2020 10:25 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>; Lukas Wunner
> <lukas@wunner.de>; Aaron Zakhrov <aaron.zakhrov@gmail.com>; Michal
> Rostecki <mrostecki@suse.com>; Linux PCI <linux-pci@vger.kernel.org>;
> Rafael J. Wysocki <rjw@rjwysocki.net>; amd-gfx list <amd-
> gfx@lists.freedesktop.org>; ACPI Devel Maling List <linux-
> acpi@vger.kernel.org>; Shai Coleman <git@shaicoleman.com>; Bjorn
> Helgaas <helgaas@kernel.org>; Arthur Borsboom
> <arthurborsboom@gmail.com>; matoro <matoro@airmail.cc>; Mika
> Westerberg <mika.westerberg@linux.intel.com>; Len Brown
> <lenb@kernel.org>
> Subject: Re: [PATCH] PCI/ACPI: Whitelist hotplug ports for D3 if power
> managed by ACPI
> 
> On Fri, Oct 2, 2020 at 4:20 PM Deucher, Alexander
> <Alexander.Deucher@amd.com> wrote:
> >
> > [AMD Public Use]
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > Rafael J. Wysocki
> > > Sent: Friday, October 2, 2020 10:17 AM
> > > To: Lukas Wunner <lukas@wunner.de>
> > > Cc: Aaron Zakhrov <aaron.zakhrov@gmail.com>; Michal Rostecki
> > > <mrostecki@suse.com>; Linux PCI <linux-pci@vger.kernel.org>; Rafael J.
> > > Wysocki <rjw@rjwysocki.net>; amd-gfx list <amd-
> > > gfx@lists.freedesktop.org>; ACPI Devel Maling List <linux-
> > > acpi@vger.kernel.org>; Shai Coleman <git@shaicoleman.com>; Bjorn
> > > Helgaas <helgaas@kernel.org>; Arthur Borsboom
> > > <arthurborsboom@gmail.com>; matoro <matoro@airmail.cc>; Deucher,
> > > Alexander <Alexander.Deucher@amd.com>; Mika Westerberg
> > > <mika.westerberg@linux.intel.com>; Len Brown <lenb@kernel.org>
> > > Subject: Re: [PATCH] PCI/ACPI: Whitelist hotplug ports for D3 if
> > > power managed by ACPI
> > >
> > > On Fri, Oct 2, 2020 at 7:17 AM Lukas Wunner <lukas@wunner.de> wrote:
> > > >
> > > > Recent laptops with dual AMD GPUs fail to suspend the discrete
> > > > GPU, thus causing lockups on system sleep and high power
> > > > consumption at
> > > runtime.
> > > > The discrete GPU would normally be suspended to D3cold by turning
> > > > off ACPI _PR3 Power Resources of the Root Port above the GPU.
> > > >
> > > > However on affected systems, the Root Port is hotplug-capable and
> > > > pci_bridge_d3_possible() only allows hotplug ports to go to D3 if
> > > > they belong to a Thunderbolt device or if the Root Port possesses
> > > > a "HotPlugSupportInD3" ACPI property.  Neither is the case on
> > > > affected laptops.  The reason for whitelisting only specific,
> > > > known to work hotplug ports for D3 is that there have been reports
> > > > of SkyLake Xeon-SP systems raising Hardware Error NMIs upon
> > > > suspending their
> > > hotplug ports:
> > > >
> > >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flo
> > > re
> > > > .kernel.org%2Flinux-pci%2F20170503180426.GA4058%40otc-nc-
> > > 03%2F&amp;dat
> > > >
> > >
> a=02%7C01%7Calexander.deucher%40amd.com%7C99ec20b6d4dc410baf800
> > > 8d866dd
> > > >
> > >
> e688%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6373724505855
> > > 84491&a
> > > >
> > >
> mp;sdata=EPFyxPA0MDBuAkvH7bbp2wHYnpos8p%2BoZmzlUvvdAek%3D&a
> > > mp;reserved
> > > > =0
> > > >
> > > > But if a hotplug port is power manageable by ACPI (as can be
> > > > detected through presence of Power Resources and corresponding
> > > > _PS0 and _PS3
> > > > methods) then it ought to be safe to suspend it to D3.  To this
> > > > end, amend acpi_pci_bridge_d3() to whitelist such ports for D3.
> > > >
> > > > Link:
> > > >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > > gitl
> > > > ab.freedesktop.org%2Fdrm%2Famd%2F-
> > > %2Fissues%2F1222&amp;data=02%7C01%7C
> > > >
> > >
> alexander.deucher%40amd.com%7C99ec20b6d4dc410baf8008d866dde688%
> > > 7C3dd89
> > > >
> > >
> 61fe4884e608e11a82d994e183d%7C0%7C0%7C637372450585584491&amp;sd
> > > ata=cMj
> > > >
> > >
> LDIbjp8RQiWX8pgK2bDUH%2B0u3oquy3TqeT9QjZGE%3D&amp;reserved=0
> > > > Link:
> > > >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > > gitl
> > > > ab.freedesktop.org%2Fdrm%2Famd%2F-
> > > %2Fissues%2F1252&amp;data=02%7C01%7C
> > > >
> > >
> alexander.deucher%40amd.com%7C99ec20b6d4dc410baf8008d866dde688%
> > > 7C3dd89
> > > >
> > >
> 61fe4884e608e11a82d994e183d%7C0%7C0%7C637372450585584491&amp;sd
> > > ata=iP9
> > > >
> > >
> EqNcM15Dj4Ax%2BE6e2HaMWHEX%2B0IO3cMoi0NXWGzM%3D&amp;reser
> > > ved=0
> > > > Link:
> > > >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > > gitl
> > > > ab.freedesktop.org%2Fdrm%2Famd%2F-
> > > %2Fissues%2F1304&amp;data=02%7C01%7C
> > > >
> > >
> alexander.deucher%40amd.com%7C99ec20b6d4dc410baf8008d866dde688%
> > > 7C3dd89
> > > >
> > >
> 61fe4884e608e11a82d994e183d%7C0%7C0%7C637372450585584491&amp;sd
> > > ata=VlT
> > > >
> UV2UCH4RvKgTXZcpGOpkjZpfijmPgwtvKx6HRT04%3D&amp;reserved=0
> > > > Reported-and-tested-by: Arthur Borsboom
> <arthurborsboom@gmail.com>
> > > > Reported-and-tested-by: matoro <matoro@airmail.cc>
> > > > Reported-by: Aaron Zakhrov <aaron.zakhrov@gmail.com>
> > > > Reported-by: Michal Rostecki <mrostecki@suse.com>
> > > > Reported-by: Shai Coleman <git@shaicoleman.com>
> > > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > > Cc: stable@vger.kernel.org
> > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > ---
> > > >  drivers/pci/pci-acpi.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c index
> > > > d5869a0..d9aa551 100644
> > > > --- a/drivers/pci/pci-acpi.c
> > > > +++ b/drivers/pci/pci-acpi.c
> > > > @@ -944,6 +944,16 @@ static bool acpi_pci_bridge_d3(struct pci_dev
> > > *dev)
> > > >         if (!dev->is_hotplug_bridge)
> > > >                 return false;
> > > >
> > > > +       /* Assume D3 support if the bridge is power-manageable by ACPI.
> */
> > > > +       adev = ACPI_COMPANION(&dev->dev);
> > > > +       if (!adev && !pci_dev_is_added(dev)) {
> > > > +               adev = acpi_pci_find_companion(&dev->dev);
> > > > +               ACPI_COMPANION_SET(&dev->dev, adev);
> > > > +       }
> > > > +
> > > > +       if (adev && acpi_device_power_manageable(adev))
> > > > +               return true;
> > > > +
> > > >         /*
> > > >          * Look for a special _DSD property for the root port and if it
> > > >          * is set we know the hierarchy behind it supports D3 just fine.
> > > > --
> > >
> > > I'm going to apply this patch for 5.10 unless Bjorn would rather
> > > route it through the PCI tree.
> >
> > Any chance we can get this into stable at some point as well?  It would be
> nice to fix the laptops out there in the wild running older kernels.
> 
> I can mark it for stable, but I'm not sure which releases it should go back to.

5.4 is the oldest kernel that supports the GPUs on this platform.

Alex

> 
> Thanks!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
