From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drm/amd/display: avoid 64-bit division
Date: Tue, 9 Jul 2019 21:37:54 +0200
Message-ID: <CAK8P3a2GbpkDnpq_MS4iRe7HM0MTxSkx=rB0=OHQZk4TXbvh1Q@mail.gmail.com>
References: <20190708135238.651483-1-arnd@arndb.de> <DM6PR12MB320967C48957C4F2F0E92438FEF10@DM6PR12MB3209.namprd12.prod.outlook.com>
 <BN6PR12MB1809956A9C61870CB7F675F5F7F10@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BN6PR12MB1809956A9C61870CB7F675F5F7F10@BN6PR12MB1809.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Abramov, Slava" <Slava.Abramov@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Liu, Charlene" <Charlene.Liu@amd.com>, "Park, Chris" <Chris.Park@amd.com>, "Cheng, Tony" <Tony.Cheng@amd.com>, "Francis, David" <David.Francis@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Cornij, Nikola" <Nikola.Cornij@amd.com>, "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Lei, Jun" <Jun.Lei@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 9, 2019 at 6:40 PM Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> I'll just apply Arnd's patch.  If the display team wants to adjust it later to clarify the
> operation, they should go ahead as a follow up patch.

Thanks!

> From: Abramov, Slava
> Sent: Tuesday, July 9, 2019 12:31 PM
> > Thanks for bisecting this issue.
> >
> > I wonder whether you are going to commit your patch or planning to update it and it's
> > still in your work queue.  We have one of our 32-bit builds failing because of this
> > issue, so that I would like either to fix it or wait to your fix if it has chances to go
> > upstream today.

I was going to update the patch, but had not gotten to that yet.

     Arnd
