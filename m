From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Subject: Re: [PATCH 1/2] drm: replace Compliance/Margin magic numbers with
 PCI_EXP_LNKCTL2 definitions
Date: Thu, 7 Nov 2019 16:49:17 -0600
Message-ID: <CABhMZUWFZ7M1wpnWaTs3+OsWqN8Nq6c8zyCCSxXbq0qZSjvgnw@mail.gmail.com>
References: <20191107222047.125496-1-helgaas@kernel.org> <20191107222047.125496-2-helgaas@kernel.org>
 <CAKb7Uvjj+18cAFW+yBEHWkJLXVTHVMW=zJ-V+uqpzdbcEKsHrQ@mail.gmail.com>
Reply-To: bjorn@helgaas.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKb7Uvjj+18cAFW+yBEHWkJLXVTHVMW=zJ-V+uqpzdbcEKsHrQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Frederick Lawler <fred@fredlawl.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Nov 7, 2019 at 4:30 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>
> On Thu, Nov 7, 2019 at 5:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index 29d6e93fd15e..03446be8a7be 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -673,6 +673,8 @@
> >  #define  PCI_EXP_LNKCTL2_TLS_8_0GT     0x0003 /* Supported Speed 8GT/s */
> >  #define  PCI_EXP_LNKCTL2_TLS_16_0GT    0x0004 /* Supported Speed 16GT/s */
> >  #define  PCI_EXP_LNKCTL2_TLS_32_0GT    0x0005 /* Supported Speed 32GT/s */
> > +#define  PCI_EXP_LNKCTL2_ENTER_COMP    0x0010 /* Enter Compliance */
> > +#define  PCI_EXP_LNKCTL2_TX_MARGIN     0x0380 /* Enter Compliance */
>
> Without commenting on the meat of the patch, this comment should
> probably read "Transmit Margin" or something along those lines?

Indeed, thank you!
